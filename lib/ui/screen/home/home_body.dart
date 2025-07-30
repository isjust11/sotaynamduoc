import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/news/news.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/api_constant.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<String> carouselImages = [
    Assets.images.icIntro1.path,
    Assets.images.icIntro2.path,
  ];

  int _current = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, String>> fakeProducts = List.generate(
    12,
    (i) => {
      'name': 'Bài thuốc nổi bật ${i + 1}',
      'image': Assets.images.sampleMedicine.path,
    },
  );

  // Thêm biến cho nhóm sản phẩm
  int _currentProductGroup = 0;
  late final int _productGroupCount;
  final PageController _productPageController = PageController();

  @override
  void initState() {
    super.initState();
    _productGroupCount = (fakeProducts.length / 6).ceil();
    context.read<NewsBloc>().add(LoadNewsList(page: 1, size: 10, search: ''));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_12,
          vertical: AppDimens.SIZE_12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Carousel slider
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: AppDimens.SIZE_162,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                enlargeFactor: 0.4,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: carouselImages
                  .map(
                    (img) => ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimens.SIZE_12,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.secondaryBrand,
                              AppColors.orangeDot,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Image.asset(
                          img,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            // Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carouselImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: AppDimens.SIZE_8,
                    height: AppDimens.SIZE_8,
                    margin: EdgeInsets.symmetric(
                      vertical: AppDimens.SIZE_8,
                      horizontal: AppDimens.SIZE_4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key
                          ? AppColors.orangeDot
                          : AppColors.lightOrangeDot,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: AppDimens.SIZE_16),
            // 2. bài thuốc nổi bật
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextLabel(
                  AppLocalizations.current.featuredMedicine,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimens.SIZE_14,
                  color: AppColors.secondaryTextDark,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fakeProductScreen);
                  },
                  child: Row(
                    children: [
                      CustomTextLabel(
                        AppLocalizations.current.viewMore,
                        color: AppColors.primaryBlue,
                        fontSize: AppDimens.SIZE_11,
                      ),
                      SizedBox(width: AppDimens.SIZE_4),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryBlue,
                        size: AppDimens.SIZE_14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.SIZE_12),
            // BẮT ĐẦU: Sản phẩm giả với điều hướng trái/phải
            SizedBox(
              height: AppDimens.SIZE_280,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _productPageController,
                    itemCount: _productGroupCount,
                    onPageChanged: (index) {
                      setState(() {
                        _currentProductGroup = index;
                      });
                    },
                    itemBuilder: (context, groupIdx) {
                      final start = groupIdx * 6;
                      final end = (start + 6).clamp(0, fakeProducts.length);
                      final group = fakeProducts.sublist(start, end);

                      // Chia group thành 2 hàng, mỗi hàng 3 sản phẩm
                      List<Widget> rows = [];
                      for (int row = 0; row < 2; row++) {
                        final rowStart = row * 3;
                        final rowEnd = (rowStart + 3).clamp(0, group.length);
                        if (rowStart < group.length) {
                          rows.add(
                            Row(
                              children: group
                                  .sublist(rowStart, rowEnd)
                                  .map(
                                    (product) => Expanded(
                                      child: Container(
                                        width: AppDimens.SIZE_120,
                                        margin: EdgeInsets.only(
                                          bottom: AppDimens.SIZE_12,
                                          right: AppDimens.SIZE_8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              product['image'] ?? '',
                                              height: AppDimens.SIZE_90,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: AppDimens.SIZE_4),
                                            CustomTextLabel(
                                              product['name'] ?? '',
                                              fontSize: AppDimens.SIZE_12,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppColors.secondaryTextDark,
                                            ),
                                          ],
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
                          right: _currentProductGroup < _productGroupCount - 1
                              ? AppDimens.SIZE_14
                              : AppDimens.SIZE_0,
                          left: _currentProductGroup > 0
                              ? AppDimens.SIZE_14
                              : AppDimens.SIZE_0,
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: AppDimens.SIZE_12),
                        child: Column(children: rows),
                      );
                    },
                  ),
                  // Nút sang trái
                  if (_currentProductGroup > 0)
                    Positioned(
                      left: 0,
                      top: AppDimens.SIZE_100,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        iconSize: AppDimens.SIZE_26,
                        color: AppColors.baseColor,
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
                  // Nút sang phải
                  if (_currentProductGroup < _productGroupCount - 1)
                    Positioned(
                      right: 0,
                      top: AppDimens.SIZE_100,
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        iconSize: AppDimens.SIZE_26,
                        color: AppColors.baseColor,
                        onPressed: () {
                          if (_currentProductGroup < _productGroupCount - 1) {
                            _productPageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                ],
              ),
            ),
            // KẾT THÚC: Sản phẩm giả với điều hướng trái/phải
            SizedBox(height: AppDimens.SIZE_24),
            // 3. Tin tức
            InkWell(
              onTap: () => Navigator.pushNamed(context, Routes.newsListScreen),
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
                        fontSize: AppDimens.SIZE_11,
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
            SizedBox(
              height: AppDimens.SIZE_200,
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
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, NewsModel news) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.newsDetailScreen, arguments: news),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 180.sh,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                  child: news.thumbnail != null
                      ? Image.network(
                          ApiConstant.apiHost + (news.thumbnail ?? ''),
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.lightGreyBackground,
                              child: Icon(
                                Icons.image_not_supported,
                                size: 60.sw,
                                color: AppColors.textMediumGrey,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.lightGreyBackground,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 60,
                            color: AppColors.textMediumGrey,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: AppDimens.SIZE_4),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimens.SIZE_2, horizontal: AppDimens.SIZE_2),
                child: CustomTextLabel(
                  news.title ?? '',
                  maxLines: 2,
                  fontSize: AppDimens.SIZE_14,
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
