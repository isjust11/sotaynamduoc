import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scale_size/scale_size.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/blocs/tip/tip_cubit.dart';
import 'package:sotaynamduoc/blocs/tip/tip_state.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/ui/widget/base_appbar.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';
import 'package:sotaynamduoc/ui/screen/shortcut_page/tip/tip_detail_screen.dart';

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  State<TipScreen> createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = '';
  String _selectedDifficulty = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<TipCubit>().getTipList();
    context.read<TipCubit>().getTipCategories();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: AppLocalizations.current.tips.toUpperCase(),
      customAppBar: _buildAppBar(context),
      body: Column(
        children: [
          // _buildSearchAndFilterSection(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllTipsTab(),
                _buildPopularTipsTab(),
                _buildRecentTipsTab(),
                _buildBookmarkedTipsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SearchAppBar _buildAppBar(BuildContext context) {
    return SearchAppBar(
      title: AppLocalizations.current.tips,
      showBackButton: true,
      backgroundColor: AppColors.secondaryBrand,
      onSearchChanged: (value) {
        // _debounceTimer?.cancel();
      },
      onSearchCanceled: () {},
      // onSearchCanceled: () {
      //   context.read<TipCubit>().getTipList();
      // },
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: AppColors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: AppColors.primaryBlue,
        unselectedLabelColor: AppColors.textMediumGrey,
        indicatorColor: AppColors.primaryBlue,
        indicatorWeight: 1,
        labelStyle: TextStyle(fontSize: 12.sw, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sw,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(text: AppLocalizations.current.all),
          Tab(text: AppLocalizations.current.popular),
          Tab(text: AppLocalizations.current.recent),
          Tab(text: AppLocalizations.current.bookmarked),
        ],
      ),
    );
  }

  Widget _buildAllTipsTab() {
    return BlocBuilder<TipCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingTipListState) {
          return _buildLoadingWidget();
        } else if (state is LoadedTipListState) {
          return _buildTipsList(state.tips);
        } else if (state is ErrorTipListState) {
          return _buildErrorWidget(state.message);
        }
        return _buildEmptyWidget();
      },
    );
  }

  Widget _buildPopularTipsTab() {
    return BlocBuilder<TipCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingPopularTipsState) {
          return _buildLoadingWidget();
        } else if (state is LoadedPopularTipsState) {
          return _buildTipsList(state.popularTips);
        } else if (state is ErrorPopularTipsState) {
          return _buildErrorWidget(state.message);
        }
        return _buildEmptyWidget();
      },
    );
  }

  Widget _buildRecentTipsTab() {
    return BlocBuilder<TipCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingRecentTipsState) {
          return _buildLoadingWidget();
        } else if (state is LoadedRecentTipsState) {
          return _buildTipsList(state.recentTips);
        } else if (state is ErrorRecentTipsState) {
          return _buildErrorWidget(state.message);
        }
        return _buildEmptyWidget();
      },
    );
  }

  Widget _buildBookmarkedTipsTab() {
    return BlocBuilder<TipCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingBookmarkedTipsState) {
          return _buildLoadingWidget();
        } else if (state is LoadedBookmarkedTipsState) {
          return _buildTipsList(state.bookmarkedTips);
        } else if (state is ErrorBookmarkedTipsState) {
          return _buildErrorWidget(state.message);
        }
        return _buildEmptyWidget();
      },
    );
  }

  Widget _buildTipsList(List<TipModel> tips) {
    if (tips.isEmpty) {
      return _buildEmptyWidget();
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.sw),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];
        return _buildTipCard(tip);
      },
    );
  }

  Widget _buildTipCard(TipModel tip) {
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
        onTap: () => _navigateToTipDetail(tip),
        borderRadius: BorderRadius.circular(12.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            if (tip.thumbnail != null && tip.thumbnail!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.sw),
                  topRight: Radius.circular(12.sw),
                ),
                child: BaseNetworkImage(
                  url: tip.thumbnail!,
                  width: double.infinity,
                  height: 200.sw,
                  fit: BoxFit.cover,
                ),
              ),
            // Content
            Padding(
              padding: EdgeInsets.all(16.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  CustomTextLabel(
                    tip.title ?? '',
                    fontSize: 16.sw,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    maxLines: 2,
                  ),
                  SizedBox(height: 8.sw),
                  // Summary
                  CustomTextLabel(
                    tip.summary ?? '',
                    fontSize: 14.sw,
                    color: AppColors.textMediumGrey,
                    maxLines: 3,
                  ),
                  SizedBox(height: 12.sw),
                  // Meta info
                  Row(
                    children: [
                      _buildMetaInfo(
                        Icons.schedule,
                        tip.estimatedTime ?? '5 phút',
                        AppColors.textMediumGrey,
                      ),
                      SizedBox(width: 16.sw),
                      _buildMetaInfo(
                        Icons.trending_up,
                        tip.difficulty ?? 'Dễ',
                        AppColors.textMediumGrey,
                      ),
                      const Spacer(),
                      _buildActionButtons(tip),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaInfo(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 14.sw, color: color),
        SizedBox(width: 4.sw),
        CustomTextLabel(text, fontSize: 12.sw, color: color),
      ],
    );
  }

  Widget _buildActionButtons(TipModel tip) {
    return Row(
      children: [
        // Like button
        GestureDetector(
          onTap: () {
            if (tip.isLiked == true) {
              context.read<TipCubit>().unlikeTip(tip.id!);
            } else {
              context.read<TipCubit>().likeTip(tip.id!);
            }
          },
          child: Icon(
            tip.isLiked == true ? Icons.favorite : Icons.favorite_border,
            size: 20.sw,
            color: tip.isLiked == true
                ? AppColors.errorRed
                : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 16.sw),
        // Bookmark button
        GestureDetector(
          onTap: () {
            if (tip.isBookmarked == true) {
              context.read<TipCubit>().unbookmarkTip(tip.id!);
            } else {
              context.read<TipCubit>().bookmarkTip(tip.id!);
            }
          },
          child: Icon(
            tip.isBookmarked == true ? Icons.bookmark : Icons.bookmark_border,
            size: 20.sw,
            color: tip.isBookmarked == true
                ? AppColors.primaryBlue
                : AppColors.textMediumGrey,
          ),
        ),
        SizedBox(width: 16.sw),
        // Share button
        GestureDetector(
          onTap: () {
            context.read<TipCubit>().shareTip(tip.id!);
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

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryBlue),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.loading,
            fontSize: 14.sw,
            color: AppColors.textMediumGrey,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48.sw, color: AppColors.errorRed),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            message,
            fontSize: 14.sw,
            color: AppColors.textDark,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.sw),
          ElevatedButton(
            onPressed: () {
              context.read<TipCubit>().getTipList(refresh: true);
            },
            child: CustomTextLabel(
              AppLocalizations.current.retry,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 48.sw,
            color: AppColors.textMediumGrey,
          ),
          SizedBox(height: 16.sw),
          CustomTextLabel(
            AppLocalizations.current.noTipsFound,
            fontSize: 14.sw,
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 8.sw),
          CustomTextLabel(
            AppLocalizations.current.tryDifferentSearch,
            fontSize: 12.sw,
            color: AppColors.textMediumGrey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _navigateToTipDetail(TipModel tip) {
    if (tip.id != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TipDetailScreen(tipId: tip.id!),
        ),
      );
    }
  }
}
