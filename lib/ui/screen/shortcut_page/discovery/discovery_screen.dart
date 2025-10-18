import 'package:flutter/material.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class DiscoveryScreen extends StatefulWidget {
  const DiscoveryScreen({super.key});

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _featuredPageController = PageController();
  int _currentFeaturedIndex = 0;
  String _searchQuery = '';

  // Mock data for demonstration
  final List<Map<String, dynamic>> _featuredItems = [
    {
      'id': '1',
      'title': 'Xu hướng sử dụng dược liệu trong năm 2024',
      'summary':
          'Khám phá những xu hướng mới nhất trong việc sử dụng dược liệu truyền thống...',
      'thumbnail': 'https://via.placeholder.com/400x250',
      'type': 'trending',
      'views': 5420,
      'likes': 128,
      'isLiked': false,
      'isBookmarked': false,
      'author': 'Viện Nghiên cứu Dược liệu',
      'publishDate': '2024-01-15',
    },
    {
      'id': '2',
      'title': 'Công nghệ AI trong phân tích dược tính',
      'summary':
          'Ứng dụng trí tuệ nhân tạo để phân tích và đánh giá chất lượng dược liệu...',
      'thumbnail': 'https://via.placeholder.com/400x250',
      'type': 'innovation',
      'views': 3890,
      'likes': 95,
      'isLiked': true,
      'isBookmarked': false,
      'author': 'Trung tâm Công nghệ Y học',
      'publishDate': '2024-01-12',
    },
    {
      'id': '3',
      'title': 'Nghiên cứu mới về tác dụng của Linh chi đỏ',
      'summary':
          'Những phát hiện mới về cơ chế hoạt động và tác dụng của Linh chi đỏ...',
      'thumbnail': 'https://via.placeholder.com/400x250',
      'type': 'research',
      'views': 6780,
      'likes': 156,
      'isLiked': false,
      'isBookmarked': true,
      'author': 'Đại học Y Hà Nội',
      'publishDate': '2024-01-10',
    },
  ];

  final List<Map<String, dynamic>> _trendingItems = [
    {
      'id': '1',
      'title': 'Top 10 dược liệu được tìm kiếm nhiều nhất',
      'summary':
          'Danh sách các dược liệu được người dùng quan tâm nhiều nhất...',
      'thumbnail': 'https://via.placeholder.com/200x150',
      'category': 'Thống kê',
      'views': 12500,
      'trend': 'up',
    },
    {
      'id': '2',
      'title': 'Cách nhận biết dược liệu thật - giả',
      'summary': 'Hướng dẫn chi tiết cách phân biệt dược liệu thật và giả...',
      'thumbnail': 'https://via.placeholder.com/200x150',
      'category': 'Hướng dẫn',
      'views': 8900,
      'trend': 'up',
    },
    {
      'id': '3',
      'title': 'Kinh nghiệm từ các chuyên gia',
      'summary': 'Chia sẻ kinh nghiệm quý báu từ các chuyên gia...',
      'thumbnail': 'https://via.placeholder.com/200x150',
      'category': 'Kinh nghiệm',
      'views': 15600,
      'trend': 'up',
    },
  ];

  final List<Map<String, dynamic>> _recommendedItems = [
    {
      'id': '1',
      'title': 'Dành cho bạn',
      'subtitle': 'Dựa trên lịch sử tìm kiếm',
      'items': [
        {
          'title': 'Công dụng của Nhân sâm Hàn Quốc',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 3200,
        },
        {
          'title': 'Cách sử dụng Đông trùng hạ thảo',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 2800,
        },
        {
          'title': 'Phân biệt các loại Linh chi',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 4100,
        },
      ],
    },
    {
      'id': '2',
      'title': 'Xu hướng mới',
      'subtitle': 'Nội dung đang được quan tâm',
      'items': [
        {
          'title': 'Ứng dụng công nghệ trong dược liệu',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 5600,
        },
        {
          'title': 'Nghiên cứu mới về dược tính',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 4800,
        },
        {
          'title': 'Bảo tồn dược liệu quý hiếm',
          'thumbnail': 'https://via.placeholder.com/150x100',
          'views': 3900,
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _startFeaturedCarousel();
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
      final nextIndex = (_currentFeaturedIndex + 1) % _featuredItems.length;
      _featuredPageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    _startFeaturedCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.discovery,
      customAppBar: _buildAppBar(context),
      body: _buildMainContent(),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.discovery,
      showBackButton: true,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      onSearchCanceled: () {
        setState(() {
          _searchQuery = '';
        });
      },
    );
  }

  Widget _buildMainContent() {
    if (_searchQuery.isNotEmpty) {
      return _buildSearchResults();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildFeaturedSection(),
          _buildTrendingSection(),
          _buildRecommendedSection(),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    // Combine all items for search
    List<Map<String, dynamic>> allItems = [];
    allItems.addAll(_featuredItems);
    allItems.addAll(_trendingItems);

    // Add recommended items
    for (var section in _recommendedItems) {
      for (var item in section['items']) {
        allItems.add({
          'id': '${section['id']}_${item['title']}',
          'title': item['title'],
          'summary': '',
          'thumbnail': item['thumbnail'],
          'views': item['views'],
          'type': 'recommended',
        });
      }
    }

    // Filter by search query
    final filteredItems = allItems
        .where(
          (item) =>
              item['title'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              (item['summary'] != null &&
                  item['summary'].toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  )),
        )
        .toList();

    if (filteredItems.isEmpty) {
      return _buildEmptySearchResults();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.sw),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
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

  Widget _buildSearchResultCard(Map<String, dynamic> item) {
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
                      item['title'],
                      fontSize: 14.sw,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    if (item['summary'] != null &&
                        item['summary'].isNotEmpty) ...[
                      SizedBox(height: 4.sw),
                      CustomTextLabel(
                        item['summary'],
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
                          '${item['views']} lượt xem',
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

  Widget _buildFeaturedSection() {
    return Container(
      padding: EdgeInsets.all(16.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured carousel
          _buildFeaturedCarousel(),
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

  Widget _buildFeaturedCarousel() {
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
            itemCount: _featuredItems.length,
            itemBuilder: (context, index) {
              final item = _featuredItems[index];
              return _buildFeaturedCard(item);
            },
          ),
        ),
        SizedBox(height: 12.sw),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _featuredItems.length,
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

  Widget _buildFeaturedCard(Map<String, dynamic> item) {
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
                        _getTypeLabel(item['type']),
                        fontSize: 10.sw,
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.sw),
                    // Title
                    CustomTextLabel(
                      item['title'],
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
                          '${item['views']} lượt xem',
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
                          '${item['likes']} thích',
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
                    icon: item['isLiked']
                        ? Icons.favorite
                        : Icons.favorite_border,
                    onTap: () {
                      setState(() {
                        item['isLiked'] = !item['isLiked'];
                        if (item['isLiked']) {
                          item['likes']++;
                        } else {
                          item['likes']--;
                        }
                      });
                    },
                    color: item['isLiked']
                        ? AppColors.errorRed
                        : AppColors.white,
                  ),
                  SizedBox(width: 8.sw),
                  _buildFloatingActionButton(
                    icon: item['isBookmarked']
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    onTap: () {
                      setState(() {
                        item['isBookmarked'] = !item['isBookmarked'];
                      });
                    },
                    color: item['isBookmarked']
                        ? AppColors.primaryBlue
                        : AppColors.white,
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
              ),
            ),
            SizedBox(width: 12.sw),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.star,
                title: 'Yêu thích',
                subtitle: 'Mục yêu thích của bạn',
                color: AppColors.primaryBlue,
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
              ),
            ),
            SizedBox(width: 12.sw),
            Expanded(
              child: _buildQuickActionCard(
                icon: Icons.bookmark,
                title: 'Đánh dấu',
                subtitle: 'Mục đã lưu',
                color: AppColors.primaryBlue,
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
          // Navigate to category
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

  Widget _buildTrendingSection() {
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
            itemCount: _trendingItems.length,
            itemBuilder: (context, index) {
              final item = _trendingItems[index];
              return _buildTrendingCard(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingCard(Map<String, dynamic> item) {
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
                      item['title'],
                      fontSize: 14.sw,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                      maxLines: 2,
                    ),
                    SizedBox(height: 4.sw),
                    // Category
                    CustomTextLabel(
                      item['category'],
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
                          '${item['views']} lượt xem',
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

  Widget _buildRecommendedSection() {
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
            itemCount: _recommendedItems.length,
            itemBuilder: (context, index) {
              final section = _recommendedItems[index];
              return _buildRecommendedSectionItem(section);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSectionItem(Map<String, dynamic> section) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          CustomTextLabel(
            section['title'],
            fontSize: 18.sw,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          SizedBox(height: 4.sw),
          CustomTextLabel(
            section['subtitle'],
            fontSize: 12.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 12.sw),
          // Items grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.sw,
              mainAxisSpacing: 12.sw,
              childAspectRatio: 1.2,
            ),
            itemCount: section['items'].length,
            itemBuilder: (context, index) {
              final item = section['items'][index];
              return _buildRecommendedItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedItem(Map<String, dynamic> item) {
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
                      item['title'],
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
                          '${item['views']} lượt xem',
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
