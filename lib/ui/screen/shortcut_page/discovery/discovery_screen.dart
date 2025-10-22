import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _featuredPageController = PageController();
  int _currentFeaturedIndex = 0;

  @override
  void initState() {
    super.initState();
    _startFeaturedCarousel();
    // Load discovery data
    context.read<DiscoveryBloc>().add(const LoadDiscoveryData());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _featuredPageController.dispose();
    super.dispose();
  }

  void _startFeaturedCarousel() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _nextFeaturedItem();
      }
    });
  }

  void _nextFeaturedItem() {
    if (_featuredPageController.hasClients) {
      // Get current state to access featured items
      final currentState = context.read<DiscoveryBloc>().state;
      if (currentState is DiscoveryDataLoaded) {
        final nextIndex =
            (_currentFeaturedIndex + 1) % currentState.featuredItems.length;
        _featuredPageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
    _startFeaturedCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.discovery,
      customAppBar: _buildAppBar(context),
      body: BlocBuilder<DiscoveryBloc, DiscoveryState>(
        builder: (context, state) {
          if (state is DiscoveryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DiscoveryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.sw,
                    color: AppColors.errorRed,
                  ),
                  SizedBox(height: 16.sw),
                  CustomTextLabel(
                    state.message,
                    fontSize: 16.sw,
                    color: AppColors.textDark,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.sw),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DiscoveryBloc>().add(
                        const LoadDiscoveryData(),
                      );
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          } else if (state is DiscoveryDataLoaded) {
            return _buildMainContent(state);
          } else if (state is DiscoverySearchLoaded) {
            return _buildSearchResults(state.searchResults);
          } else if (state is DiscoveryEmpty) {
            return _buildEmptyState(state.message);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.discovery,
      showBackButton: true,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        if (value.isNotEmpty) {
          context.read<DiscoveryBloc>().add(SearchDiscovery(value));
        } else {
          context.read<DiscoveryBloc>().add(const LoadDiscoveryData());
        }
      },
      onSearchCanceled: () {
        context.read<DiscoveryBloc>().add(const LoadDiscoveryData());
      },
    );
  }

  Widget _buildMainContent(DiscoveryDataLoaded state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFeaturedSection(state.featuredItems),
          _buildTrendingSection(state.trendingItems),
          _buildRecommendedSection(state.recommendedItems),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<NewsModel> searchResults) {
    if (searchResults.isEmpty) {
      return _buildEmptySearchResults();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.sw),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return _buildSearchResultCard(item);
      },
    );
  }

  Widget _buildEmptySearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 48.sw, color: AppColors.textMediumGrey),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            'Không tìm thấy kết quả nào',
            fontSize: 16.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.sw),
          CustomTextLabel(
            'Thử tìm kiếm với từ khóa khác',
            fontSize: 14.sw,
            color: AppColors.textMediumGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            message,
            fontSize: 16.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.sw),
          ElevatedButton(
            onPressed: () {
              context.read<DiscoveryBloc>().add(const LoadDiscoveryData());
            },
            child: const Text('Tải lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultCard(NewsModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to item detail
        },
        borderRadius: BorderRadius.circular(12.sw),
        child: Padding(
          padding: EdgeInsets.all(16.sw),
          child: Row(
            children: [
              Container(
                width: 80.sw,
                height: 80.sw,
                decoration: BoxDecoration(
                  color: AppColors.lightGreyBackground,
                  borderRadius: BorderRadius.circular(8.sw),
                ),
                child: Icon(
                  Icons.article_outlined,
                  size: 32.sw,
                  color: AppColors.textMediumGrey,
                ),
              ),
              SizedBox(width: 12.sw),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLabel(
                      item.title,
                      fontSize: 14.sw,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    if (item.summary != null && item.summary!.isNotEmpty) ...[
                      SizedBox(height: 4.sw),
                      CustomTextLabel(
                        item.summary!,
                        fontSize: 12.sw,
                        color: AppColors.textMediumGrey,
                        maxLines: 2,
                      ),
                    ],
                    SizedBox(height: 8.sw),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.viewCount} lượt xem',
                          fontSize: 12.sw,
                          color: AppColors.textMediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection(List<NewsModel> featuredItems) {
    return Container(
      padding: EdgeInsets.all(16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured carousel
          _buildFeaturedCarousel(featuredItems),
          SizedBox(height: 24.sw),
          // Quick actions
          _buildQuickActions(),
          SizedBox(height: 24.sw),
          // Categories
          _buildCategoriesSection(),
        ],
      ),
    );
  }

  Widget _buildFeaturedCarousel(List<NewsModel> featuredItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          'Nội dung nổi bật',
          fontSize: 18.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        SizedBox(height: 12.sw),
        Container(
          height: 200.sw,
          child: PageView.builder(
            controller: _featuredPageController,
            onPageChanged: (index) {
              setState(() {
                _currentFeaturedIndex = index;
              });
            },
            itemCount: featuredItems.length,
            itemBuilder: (context, index) {
              final item = featuredItems[index];
              return _buildFeaturedCard(item);
            },
          ),
        ),
        SizedBox(height: 12.sw),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            featuredItems.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.sw),
              width: 8.sw,
              height: 8.sw,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentFeaturedIndex == index
                    ? AppColors.primaryBlue
                    : AppColors.textMediumGrey.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedCard(NewsModel item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.sw),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.sw),
        child: Stack(
          children: [
            // Background image
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.lightGreyBackground,
              child: Icon(
                Icons.image_outlined,
                size: 48.sw,
                color: AppColors.textMediumGrey,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(16.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.sw,
                        vertical: 4.sw,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        borderRadius: BorderRadius.circular(4.sw),
                      ),
                      child: CustomTextLabel(
                        _getTypeLabel(item.category?.name ?? ''),
                        fontSize: 10.sw,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.sw),
                    // Title
                    CustomTextLabel(
                      item.title,
                      fontSize: 16.sw,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.sw),
                    // Meta info
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 12.sw,
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.viewCount} lượt xem',
                          fontSize: 12.sw,
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                        SizedBox(width: 16.sw),
                        Icon(
                          Icons.favorite,
                          size: 12.sw,
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.likeCount} thích',
                          fontSize: 12.sw,
                          color: AppColors.white.withValues(alpha: 0.8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Action buttons
            Positioned(
              top: 12.sw,
              right: 12.sw,
              child: Row(
                children: [
                  _buildFloatingActionButton(
                    icon: true ? Icons.favorite : Icons.favorite_border,
                    onTap: () {
                      context.read<DiscoveryBloc>().add(
                        UpdateContentLike(
                          contentId: item.id ?? '',
                          isLiked: false,
                        ),
                      );
                    },
                    color: true ? AppColors.errorRed : AppColors.white,
                  ),
                  SizedBox(width: 8.sw),
                  _buildFloatingActionButton(
                    icon: true ? Icons.bookmark : Icons.bookmark_border,
                    onTap: () {
                      context.read<DiscoveryBloc>().add(
                        UpdateContentBookmark(
                          contentId: item.id ?? '',
                          isBookmarked: false,
                        ),
                      );
                    },
                    color: true ? AppColors.primaryBlue : AppColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.sw,
        height: 32.sw,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 16.sw, color: color),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          'Thao tác nhanh',
          fontSize: 18.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        SizedBox(height: 12.sw),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.trending_up,
                title: 'Xu hướng',
                subtitle: 'Khám phá xu hướng',
                color: AppColors.primaryBlue,
                onTap: () {
                  context.read<DiscoveryBloc>().add(
                    const LoadQuickActionContent('trending'),
                  );
                },
              ),
            ),
            SizedBox(width: 12.sw),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.star,
                title: 'Yêu thích',
                subtitle: 'Mục yêu thích của bạn',
                color: AppColors.primaryBlue,
                onTap: () {
                  context.read<DiscoveryBloc>().add(
                    const LoadQuickActionContent('favorites'),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 12.sw),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.history,
                title: 'Gần đây',
                subtitle: 'Đã xem gần đây',
                color: AppColors.primaryBlue,
                onTap: () {
                  context.read<DiscoveryBloc>().add(
                    const LoadQuickActionContent('recent'),
                  );
                },
              ),
            ),
            SizedBox(width: 12.sw),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.bookmark,
                title: 'Đánh dấu',
                subtitle: 'Mục đã lưu',
                color: AppColors.primaryBlue,
                onTap: () {
                  context.read<DiscoveryBloc>().add(
                    const LoadQuickActionContent('bookmarks'),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.sw,
              height: 40.sw,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.sw),
              ),
              child: Icon(icon, color: color, size: 20.sw),
            ),
            SizedBox(height: 8.sw),
            CustomTextLabel(
              title,
              fontSize: 14.sw,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
            SizedBox(height: 4.sw),
            CustomTextLabel(
              subtitle,
              fontSize: 12.sw,
              color: AppColors.textMediumGrey,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextLabel(
          'Danh mục',
          fontSize: 18.sw,
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        SizedBox(height: 12.sw),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12.sw,
          mainAxisSpacing: 12.sw,
          childAspectRatio: 1.5,
          children: [
            _buildCategoryCard(
              'Dược liệu quý',
              Icons.eco,
              AppColors.primaryBlue,
            ),
            _buildCategoryCard(
              'Nghiên cứu',
              Icons.science,
              AppColors.primaryBlue,
            ),
            _buildCategoryCard('Kỹ thuật', Icons.build, AppColors.primaryBlue),
            _buildCategoryCard('Ứng dụng', Icons.apps, AppColors.primaryBlue),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to category - you can implement category navigation here
          // context.read<DiscoveryBloc>().add(LoadCategoryContent(categoryId));
        },
        borderRadius: BorderRadius.circular(12.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48.sw,
              height: 48.sw,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.sw),
              ),
              child: Icon(icon, color: color, size: 24.sw),
            ),
            SizedBox(height: 8.sw),
            CustomTextLabel(
              title,
              fontSize: 12.sw,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingSection(List<NewsModel> trendingItems) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            'Xu hướng',
            fontSize: 18.sw,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          SizedBox(height: 12.sw),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: trendingItems.length,
            itemBuilder: (context, index) {
              final item = trendingItems[index];
              return _buildTrendingCard(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(NewsModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.sw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Track view and navigate to item detail
          context.read<DiscoveryBloc>().add(UpdateContentView(item.id ?? ''));
          // Navigate to item detail
        },
        borderRadius: BorderRadius.circular(12.sw),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.sw),
                bottomLeft: Radius.circular(12.sw),
              ),
              child: Container(
                width: 120.sw,
                height: 100.sw,
                color: AppColors.lightGreyBackground,
                child: Icon(
                  Icons.trending_up,
                  size: 32.sw,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Trend indicator
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 16.sw,
                          color: AppColors.primaryBlue,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          'Xu hướng',
                          fontSize: 12.sw,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.sw),
                    // Title
                    CustomTextLabel(
                      item.title,
                      fontSize: 14.sw,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.sw),
                    // Category
                    CustomTextLabel(
                      item.category?.name ?? '',
                      fontSize: 12.sw,
                      color: AppColors.textMediumGrey,
                    ),
                    SizedBox(height: 8.sw),
                    // Views
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 14.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 4.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.viewCount} lượt xem',
                          fontSize: 12.sw,
                          color: AppColors.textMediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedSection(List<NewsModel> recommendedItems) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            'Gợi ý cho bạn',
            fontSize: 18.sw,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          SizedBox(height: 12.sw),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recommendedItems.length,
            itemBuilder: (context, index) {
              final item = recommendedItems[index];
              return _buildRecommendedItem(item);
            },
          ),
        ],
      ),
    );
  }

  // Widget _buildRecommendedSectionItem(List<NewsModel> item) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 24.sw),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Section header
  //         CustomTextLabel(
  //           item.title,
  //           fontSize: 18.sw,
  //           fontWeight: FontWeight.bold,
  //           color: AppColors.textDark,
  //         ),
  //         SizedBox(height: 4.sw),
  //         CustomTextLabel(
  //           item.summary ?? '',
  //           fontSize: 12.sw,
  //           color: AppColors.textMediumGrey,
  //         ),
  //         SizedBox(height: 12.sw),
  //         // Items grid
  //         GridView.builder(
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             crossAxisSpacing: 12.sw,
  //             mainAxisSpacing: 12.sw,
  //             childAspectRatio: 1.2,
  //           ),
  //           itemCount: item.length,
  //           itemBuilder: (context, index) {
  //             final item = item[index];
  //             return _buildRecommendedItem(item);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRecommendedItem(NewsModel item) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.sw),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Track view and navigate to item detail
          context.read<DiscoveryBloc>().add(UpdateContentView(item.id ?? ''));
          // Navigate to item detail
        },
        borderRadius: BorderRadius.circular(8.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.sw),
                topRight: Radius.circular(8.sw),
              ),
              child: Container(
                width: double.infinity,
                height: 80.sw,
                color: AppColors.lightGreyBackground,
                child: Icon(
                  Icons.article_outlined,
                  size: 32.sw,
                  color: AppColors.textMediumGrey,
                ),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.sw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLabel(
                      item.title,
                      fontSize: 12.sw,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      maxLines: 1,
                    ),
                    SizedBox(height: 4.sw),
                    Row(
                      children: [
                        Icon(
                          Icons.visibility,
                          size: 10.sw,
                          color: AppColors.textMediumGrey,
                        ),
                        SizedBox(width: 2.sw),
                        CustomTextLabel(
                          '${item.interactionStats?.viewCount} lượt xem',
                          fontSize: 10.sw,
                          color: AppColors.textMediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type) {
      case 'trending':
        return 'Xu hướng';
      case 'innovation':
        return 'Đổi mới';
      case 'research':
        return 'Nghiên cứu';
      default:
        return 'Nổi bật';
    }
  }
}
