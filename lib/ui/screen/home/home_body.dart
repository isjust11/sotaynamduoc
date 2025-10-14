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
    context.read<NewsBloc>().add(LoadNewsList(page: 1, size: 10, search: ''));
    context.read<FolkMedicineBloc>().add(
      LoadFolkMedicineList(page: 1, size: 10, search: ''),
    );
    _startTypewriter();
  }

  // Typewriter effect state
  final String _typewriterFullText = AppLocalizations.current.todayYouFeel;
  final String _typewriterDescription = AppLocalizations.current.youCanSearch;
  late final List<String> _typewriterMessages = [
    _typewriterFullText,
    _typewriterDescription,
  ];
  int _currentMessage = 0;
  int _typewriterIndex = 0;
  bool _typewriterDeleting = false;
  Timer? _typewriterTimer;

  void _startTypewriter([
    Duration interval = const Duration(milliseconds: 100),
  ]) {
    _typewriterTimer?.cancel();
    _typewriterTimer = Timer.periodic(interval, (timer) {
      if (!mounted) return;
      if (!_typewriterDeleting) {
        if (_typewriterIndex < _typewriterMessages[_currentMessage].length) {
          setState(() {
            _typewriterIndex++;
          });
        } else {
          timer.cancel();
          Future.delayed(const Duration(milliseconds: 900), () {
            if (!mounted) return;
            setState(() {
              _typewriterDeleting = true;
            });
            _startTypewriter(const Duration(milliseconds: 40));
          });
        }
      } else {
        if (_typewriterIndex > 0) {
          setState(() {
            _typewriterIndex--;
          });
        } else {
          timer.cancel();
          setState(() {
            _typewriterDeleting = false;
            _currentMessage =
                (_currentMessage + 1) % _typewriterMessages.length;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            if (!mounted) return;
            _startTypewriter();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _typewriterTimer?.cancel();
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
          _buildHeaderContent(context),
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
            () {},
          ),
          SizedBox(width: AppDimens.SIZE_8),
          _buildDiscoveryItem(
            context,
            AppLocalizations.current.youKnow,
            Icons.medical_information,
            AppColors.baseColor,
            () {},
          ),
          SizedBox(width: AppDimens.SIZE_8),
          _buildDiscoveryItem(
            context,
            AppLocalizations.current.discovery,
            Icons.explore,
            AppColors.primaryBlue,
            () {},
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
    Function() onTap,
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

  Widget _buildHeaderContent(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.searchScreen);
          },
          child: Container(
            width: double.infinity,
            height: AppDimens.SIZE_64,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.2),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.SIZE_12,
                vertical: AppDimens.SIZE_12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimens.SIZE_12,
                        vertical: AppDimens.SIZE_10,
                      ),
                      child: CustomTextLabel(
                        _typewriterIndex == 0
                            ? ' '
                            : _typewriterMessages[_currentMessage].substring(
                                0,
                                _typewriterIndex,
                              ),
                        color: AppColors.primaryBlue,
                        fontSize: AppDimens.SIZE_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: AppColors.primaryBlue,
                    size: AppDimens.SIZE_24,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.SIZE_12,
            vertical: AppDimens.SIZE_12,
          ),
          height: AppDimens.SIZE_310,
          child: BlocBuilder<FolkMedicineBloc, FolkMedicineState>(
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
                                          height: AppDimens.SIZE_120,
                                          margin: EdgeInsets.only(
                                            bottom: AppDimens.SIZE_12,
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
                                                      width: double.infinity,
                                                      height: AppDimens.SIZE_90,
                                                      borderRadius:
                                                          AppDimens.SIZE_8,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: AppDimens.SIZE_4,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: double.infinity,
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
                  child: news.thumbnail != null
                      ? BaseNetworkImage(
                          url: ApiConstant.storageHost + (news.thumbnail ?? ''),
                        )
                      : Container(
                          color: AppColors.lightGreyBackground,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.textMediumGrey,
                          ),
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
