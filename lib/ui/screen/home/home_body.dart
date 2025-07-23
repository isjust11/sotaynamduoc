import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sotaynamduoc/gen/assets.gen.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/routes.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final List<String> carouselImages = [Assets.images.icIntro1.path, Assets.images.icIntro2.path];

  int _current = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Map<String, String>> fakeProducts = List.generate(
    12,
    (i) => {'name': 'Sản phẩm  ${i + 1}', 'image': Assets.images.sampleProduct.path},
  );

  final List<Map<String, String>> fakeNews = List.generate(
    8,
    (i) => {'title': 'Tin tức ${i + 1}', 'image': Assets.images.icVneid.path},
  );

  // Thêm biến cho nhóm sản phẩm
  int _currentProductGroup = 0;
  late final int _productGroupCount;
  final PageController _productPageController = PageController();

  @override
  void initState() {
    super.initState();
    _productGroupCount = (fakeProducts.length / 6).ceil();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.SIZE_12, vertical: AppDimens.SIZE_12),
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
              items:
                  carouselImages
                      .map(
                        (img) => ClipRRect(
                          borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppDimens.SIZE_12),
                              gradient: LinearGradient(
                                colors: [AppColors.secondaryBrand, AppColors.orangeDot],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                      )
                      .toList(),
            ),
            // Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  carouselImages.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _carouselController.animateToPage(entry.key),
                      child: Container(
                        width: AppDimens.SIZE_8,
                        height: AppDimens.SIZE_8,
                        margin: EdgeInsets.symmetric(vertical: AppDimens.SIZE_8, horizontal: AppDimens.SIZE_4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key ? AppColors.orangeDot : AppColors.lightOrangeDot,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            SizedBox(height: AppDimens.SIZE_16),
            // 2. Cảnh báo hàng giả
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextLabel(
                  AppLocalizations.current.fakeProductWarning,
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimens.SIZE_16,
                  color: AppColors.secondaryTextDark,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.fakeProductScreen);
                  },
                  child: Row(
                    children: [
                      CustomTextLabel("xem tất cả", color: AppColors.primaryBlue),
                      SizedBox(width: AppDimens.SIZE_4),
                      Icon(Icons.arrow_forward_ios, color: AppColors.primaryBlue, size: AppDimens.SIZE_16),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimens.SIZE_12),
            // BẮT ĐẦU: Sản phẩm giả với điều hướng trái/phải
            SizedBox(
              height: AppDimens.SIZE_260,
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
                              children:
                                  group
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  product['image'] ?? '',
                                                  height: AppDimens.SIZE_90,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(
                                                  height: AppDimens.SIZE_4,
                                                ),
                                                CustomTextLabel(
                                                  product['name'] ?? '',
                                                  fontSize: AppDimens.SIZE_12,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors
                                                          .secondaryTextDark,
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
                          right:
                              _currentProductGroup < _productGroupCount - 1
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextLabel(
                  AppLocalizations.current.news,
                  fontSize: AppDimens.SIZE_18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryTextDark,
                ),
                Row(
                  children: [
                    CustomTextLabel(
                      "xem tất cả",
                      color: AppColors.primaryBlue,
                      fontSize: AppDimens.SIZE_11,
                    ),
                    SizedBox(width: AppDimens.SIZE_4),
                    Icon(Icons.arrow_forward_ios, color: AppColors.primaryBlue, size: AppDimens.SIZE_14),
                  ],
                ),
              ],
            ),
            SizedBox(height: AppDimens.SIZE_12),
            SizedBox(
              height: AppDimens.SIZE_162,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: fakeNews.length,
                separatorBuilder: (_, __) => SizedBox(width: AppDimens.SIZE_12),
                itemBuilder: (context, idx) {
                  final news = fakeNews[idx];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          news['image'] ?? '',
                          height: AppDimens.SIZE_120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: AppDimens.SIZE_8),
                        Expanded(
                          child: CustomTextLabel(
                            news['title'] ?? '',
                            maxLines: 2,
                            fontSize: AppDimens.SIZE_16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
