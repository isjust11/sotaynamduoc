import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/category/category_cubit.dart';
import 'package:sotaynamduoc/domain/data/enums/category_type.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  String _searchQuery = '';

  // Mock data for demonstration
  final List<Map<String, dynamic>> _knowledgeItems = [
    {
      'id': '1',
      'title': 'Công dụng của Nhân sâm trong y học cổ truyền',
      'summary':
          'Nhân sâm là một trong những dược liệu quý hiếm nhất, có tác dụng bổ khí, ích huyết, an thần...',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'category': 'Dược liệu quý',
      'difficulty': 'Trung bình',
      'estimatedTime': '10 phút',
      'isLiked': false,
      'isBookmarked': false,
      'views': 1250,
      'author': 'BS. Nguyễn Văn A',
    },
    {
      'id': '2',
      'title': 'Cách sử dụng Đông trùng hạ thảo hiệu quả',
      'summary':
          'Đông trùng hạ thảo là loại nấm quý hiếm, có nhiều công dụng tốt cho sức khỏe...',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'category': 'Dược liệu quý',
      'difficulty': 'Dễ',
      'estimatedTime': '8 phút',
      'isLiked': true,
      'isBookmarked': false,
      'views': 980,
      'author': 'DS. Trần Thị B',
    },
    {
      'id': '3',
      'title': 'Phân biệt các loại Linh chi và công dụng',
      'summary':
          'Linh chi có nhiều loại khác nhau, mỗi loại có công dụng riêng biệt...',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'category': 'Nấm dược liệu',
      'difficulty': 'Khó',
      'estimatedTime': '15 phút',
      'isLiked': false,
      'isBookmarked': true,
      'views': 2100,
      'author': 'TS. Lê Văn C',
    },
    {
      'id': '4',
      'title': 'Cách bảo quản dược liệu đúng cách',
      'summary':
          'Việc bảo quản dược liệu đúng cách sẽ giúp giữ được dược tính và chất lượng...',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'category': 'Kỹ thuật',
      'difficulty': 'Dễ',
      'estimatedTime': '6 phút',
      'isLiked': false,
      'isBookmarked': false,
      'views': 750,
      'author': 'ThS. Phạm Thị D',
    },
  ];

  final List<String> _categories = [
    'Tất cả',
    'Dược liệu quý',
    'Nấm dược liệu',
    'Kỹ thuật',
    'Nghiên cứu',
    'Ứng dụng',
  ];
  @override
  void initState() {
    super.initState();
    context.read<CategoryCubit>().getCategories(
      categoryTypeCode: CategoryType.Discovery.value,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.knowledge,
      customAppBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(child: _buildKnowledgeList(_getFilteredItems())),
        ],
      ),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.knowledge,
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

  Widget _buildCategoryFilter() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_8,
        vertical: AppDimens.SIZE_8,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: AppDimens.SIZE_8,
            offset: Offset(0, AppDimens.SIZE_2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: BlocBuilder<CategoryCubit, BaseState>(
          builder: (context, state) {
            if (state is LoadedState<List<CategoryModel>>) {
              final categories = state.data;
              
              return Row(
                children: categories.map((category) {
                  final isSelected = _selectedCategory == category.id;
                  return Container(
                    margin: EdgeInsets.only(right: AppDimens.SIZE_8),
                    child: FilterChip(
                      label: CustomTextLabel(
                        category.name,
                        fontSize: AppDimens.SIZE_12,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textDark,
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = (selected ? category.id : '')!;
                        });
                      },
                      backgroundColor: AppColors.lightGreyBackground,
                      selectedColor: AppColors.primaryBlue,
                      checkmarkColor: AppColors.white,
                    ),
                  );
                }).toList(),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredItems() {
    List<Map<String, dynamic>> filteredItems = _knowledgeItems;

    // Filter by category
    if (_selectedCategory.isNotEmpty &&
        _selectedCategory != AppLocalizations.current.all) {
      filteredItems = filteredItems
          .where((item) => item['category'] == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems
          .where(
            (item) =>
                item['title'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                item['summary'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                item['category'].toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filteredItems;
  }

  Widget _buildKnowledgeList(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return _buildEmptyWidget();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.sw),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildKnowledgeCard(item);
      },
    );
  }

  Widget _buildKnowledgeCard(Map<String, dynamic> item) {
    return CardColItemWidget(
      onTap: () => _navigateToKnowledgeDetail(item),
      title: item['title'],
      summary: item['summary'],
      thumbnail: item['thumbnail'],
      category: item['category'],
      estimatedTime: item['estimatedTime'],
      difficulty: item['difficulty'],
      views: item['views'],
      author: item['author'],
      isLiked: item['isLiked'],
      isBookmarked: item['isBookmarked'],
      actionButtons: _buildActionButtons(item),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Like button
        GestureDetector(
          onTap: () {
            setState(() {
              item['isLiked'] = !item['isLiked'];
            });
          },
          child: Icon(
            item['isLiked'] ? Icons.favorite : Icons.favorite_border,
            size: 20.sw,
            color: item['isLiked']
                ? AppColors.errorRed
                : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 12.sw),
        // Bookmark button
        GestureDetector(
          onTap: () {
            setState(() {
              item['isBookmarked'] = !item['isBookmarked'];
            });
          },
          child: Icon(
            item['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
            size: 20.sw,
            color: item['isBookmarked']
                ? AppColors.primaryBlue
                : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 12.sw),
        // Share button
        GestureDetector(
          onTap: () {
            // Implement share functionality
          },
          child: Icon(
            Icons.share,
            size: 20.sw,
            color: AppColors.textMediumGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 48.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.noKnowledgeFound,
            fontSize: 14.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.sw),
          CustomTextLabel(
            AppLocalizations.current.trySearchingWithDifferentKeywords,
            fontSize: 12.sw,
            color: AppColors.textMediumGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToKnowledgeDetail(Map<String, dynamic> item) {
    // Navigate to knowledge detail screen
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => KnowledgeDetailScreen(knowledgeId: item['id']),
    //   ),
    // );
  }
}
