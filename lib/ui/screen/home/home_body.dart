import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_event.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_state.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/screen/news/news_list_screen.dart';
import 'package:sotaynamduoc/ui/screen/screen.dart';
import 'package:sotaynamduoc/ui/widget/header_typing_widget.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  // Thêm biến cho nhóm sản phẩm
  int _currentProductGroup = 0;
  final PageController _productPageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<FolkMedicineBloc>().add(
      LoadFolkMedicineList(page: 1, size: 10, search: ''),
    );
    context.read<NewsBloc>().add(LoadNewsList(page: 1, size: 10, search: ''));
  }

  @override
  void dispose() {
    _productPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. build header content
          HeaderTypingWidget(),
          const SizedBox(height: AppDimens.SIZE_8),
          // 2. build discovery
          _buildDiscovery(context),
          const SizedBox(height: AppDimens.SIZE_8),
          // 3. bài thuốc nổi bật
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.SIZE_12,
              vertical: AppDimens.SIZE_8,
            ),
            child: _buildFolkMedicine(context),
          ),
          // SizedBox(height: AppDimens.SIZE_12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12),
            child: _buildNews(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscovery(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_12,
        vertical: AppDimens.SIZE_8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDiscoveryItem(
            context,
            AppLocalizations.current.tips,
            Icons.lightbulb_outline,
            AppColors.yellowMaterial,
            () => Navigator.pushNamed(context, Routes.tipListScreen),
          ),
          SizedBox(width: AppDimens.SIZE_8),
          _buildDiscoveryItem(
            context,
            AppLocalizations.current.youKnow,
            Icons.medical_information,
            AppColors.baseColor,
            () => Navigator.pushNamed(context, Routes.knowledgeListScreen),
          ),
          SizedBox(width: AppDimens.SIZE_8),
          _buildDiscoveryItem(
            context,
            AppLocalizations.current.discovery,
            Icons.explore,
            AppColors.primaryBlue,
            () => Navigator.pushNamed(context, Routes.discoveryScreen),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryItem(
    BuildContext context,
    String title,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 105.sw,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_12,
          vertical: AppDimens.SIZE_12,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGreyBackground,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
              blurRadius: AppDimens.SIZE_4,
              offset: Offset(AppDimens.SIZE_2, AppDimens.SIZE_2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: AppDimens.SIZE_24, color: iconColor),
            const SizedBox(height: AppDimens.SIZE_8),
            CustomTextLabel(
              title,
              fontSize: AppDimens.SIZE_12,
              fontWeight: FontWeight.bold,
              color: AppColors.colorTitle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNews(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsListScreen(isShowBackButton: true),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextLabel(
                AppLocalizations.current.news,
                fontSize: AppDimens.SIZE_14,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryTextDark,
              ),
              Row(
                children: [
                  CustomTextLabel(
                    AppLocalizations.current.viewMore,
                    color: AppColors.primaryBlue,
                    fontSize: AppDimens.SIZE_12,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: AppDimens.SIZE_4),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryBlue,
                    size: AppDimens.SIZE_14,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.SIZE_12),
        // 3. Tin tức
        SizedBox(
          height: 140.sh,
          child: BlocBuilder<NewsBloc, NewsState>(
            buildWhen: (prev, curr) =>
                curr is NewsListLoaded ||
                curr is NewsLoading ||
                curr is NewsError,
            builder: (context, state) {
              if (state is NewsListLoaded) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.newsList.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: AppDimens.SIZE_12),
                  itemBuilder: (context, idx) {
                    final news = state.newsList[idx];
                    return _buildNewsItem(context, news);
                  },
                );
              } else if (state is NewsLoading) {
                return const LoadingTemplate();
              } else if (state is NewsError) {
                return const EmptyData();
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFolkMedicine(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextLabel(
              AppLocalizations.current.featuredMedicine,
              fontWeight: FontWeight.bold,
              fontSize: AppDimens.SIZE_14,
              color: AppColors.secondaryTextDark,
            ),
          ],
        ),
        SizedBox(height: AppDimens.SIZE_12),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
            color: AppColors.lightBackgroundAlt,
          ),
          padding: EdgeInsets.only(
            left: AppDimens.SIZE_8,
            right: AppDimens.SIZE_8,
            top: AppDimens.SIZE_12,
          ),
          height: 320.sh,
          child: BlocBuilder<FolkMedicineBloc, FolkMedicineState>(
            buildWhen: (prev, curr) =>
                curr is FolkMedicineListLoaded ||
                curr is FolkMedicineLoading ||
                curr is FolkMedicineError,
            builder: (context, state) {
              if (state is FolkMedicineListLoaded &&
                  state.folkMedicineList.isNotEmpty) {
                final items = state.folkMedicineList;
                final int groupCount = (items.length / 4).ceil();

                return Stack(
                  children: [
                    PageView.builder(
                      controller: _productPageController,
                      itemCount: groupCount,
                      onPageChanged: (index) {
                        setState(() {
                          _currentProductGroup = index;
                        });
                      },
                      itemBuilder: (context, groupIdx) {
                        final start = groupIdx * 4;
                        final end = (start + 4) > items.length
                            ? items.length
                            : (start + 4);
                        final group = items.sublist(start, end);

                        List<Widget> rows = [];
                        for (int row = 0; row < 2; row++) {
                          final rowStart = row * 2;
                          final rowEnd = (rowStart + 2) > group.length
                              ? group.length
                              : (rowStart + 2);
                          if (rowStart < group.length) {
                            rows.add(
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: group
                                    .sublist(rowStart, rowEnd)
                                    .map(
                                      (item) => Expanded(
                                        child: Container(
                                          height: 120.sh,
                                          width: 120.sw,
                                          margin: EdgeInsets.only(
                                            bottom: AppDimens.SIZE_20,
                                            right: rowEnd - rowStart == 1
                                                ? 0
                                                : AppDimens.SIZE_8,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FolkMedicineDetailScreen(
                                                        folkMedicine: item,
                                                      ),
                                                ),
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(
                                              AppDimens.SIZE_8,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      AppDimens.SIZE_8,
                                                    ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          AppDimens.SIZE_8,
                                                        ),
                                                    child: BaseNetworkImage(
                                                      url:
                                                          ApiConstant
                                                              .storageHost +
                                                          (item.thumbnail ??
                                                              ''),
                                                      width: 140.sw,
                                                      height: 80.sh,
                                                      borderRadius:
                                                          AppDimens.SIZE_8,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: AppDimens.SIZE_8,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 140.sw,
                                                      child: CustomTextLabel(
                                                        item.title ?? '',
                                                        fontSize:
                                                            AppDimens.SIZE_12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        maxLines: 2,
                                                        color: AppColors
                                                            .secondaryTextDark,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                        }

                        return Container(
                          padding: EdgeInsets.only(
                            right: _currentProductGroup < groupCount - 1
                                ? AppDimens.SIZE_8
                                : AppDimens.SIZE_0,
                            left: _currentProductGroup > 0
                                ? AppDimens.SIZE_8
                                : AppDimens.SIZE_0,
                          ),
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: AppDimens.SIZE_12),
                          child: Column(children: rows),
                        );
                      },
                    ),
                    if (_currentProductGroup > 0)
                      Positioned(
                        left: 0,
                        top: AppDimens.SIZE_100,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          iconSize: AppDimens.SIZE_26,
                          color: AppColors.disabledGrey,
                          onPressed: () {
                            if (_currentProductGroup > 0) {
                              _productPageController.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                        ),
                      ),
                    if (_currentProductGroup < groupCount - 1)
                      Positioned(
                        right: 0,
                        top: AppDimens.SIZE_100,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: AppDimens.SIZE_26,
                          color: AppColors.disabledGrey,
                          onPressed: () {
                            if (_currentProductGroup < groupCount - 1) {
                              _productPageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                        ),
                      ),
                  ],
                );
              }
              if (state is FolkMedicineLoading) {
                return Center(child: LoadingTemplate());
              }
              return const EmptyData();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewsItem(BuildContext context, NewsModel news) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.newsDetailScreen,
        arguments: news,
      ),
      splashColor: Colors.transparent,
      child: Container(
        width: 180.sw,
        height: 120.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 100.sh,
                width: 180.sw,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                  child: BaseNetworkImage(
                    url: ApiConstant.storageHost + (news.thumbnail ?? ''),
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimens.SIZE_4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.SIZE_4,
                  horizontal: AppDimens.SIZE_2,
                ),
                child: CustomTextLabel(
                  news.title ?? '',
                  maxLines: 2,
                  fontSize: AppDimens.SIZE_12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
