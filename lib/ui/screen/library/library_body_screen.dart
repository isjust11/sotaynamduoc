import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/herbal/herbal.dart';
import 'package:sotaynamduoc/blocs/author/author.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/screen/library/detail/library_detail_screen.dart';
import 'package:sotaynamduoc/ui/screen/library/detail/author_detail_screen.dart';
import 'package:sotaynamduoc/ui/widget/card_row_item.dart';
import 'package:sotaynamduoc/ui/widget/widget.dart';

class LibraryBodyScreen extends StatefulWidget {
  const LibraryBodyScreen({super.key});

  @override
  State<LibraryBodyScreen> createState() => _LibraryBodyScreenState();
}

class _LibraryBodyScreenState extends State<LibraryBodyScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  final ScrollController _herbalScrollController = ScrollController();
  final ScrollController _authorScrollController = ScrollController();
  bool _isDisposed = false;
  late VoidCallback _tabListener;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabListener = () {
      if (!_isDisposed) {
        setState(() {});
      }
    };
    _tabController.addListener(_tabListener);

    // Load initial data
    final herbalBloc = context.read<HerbalBloc>();
    // if (herbalBloc.state is! HerbalLoaded) {
    herbalBloc.add(const GetHerbalsEvent());
    // }

    final authorBloc = context.read<AuthorBloc>();
    // if (authorBloc.state is! AuthorLoaded) {
    authorBloc.add(const GetAuthorsEvent());
    // }

    _herbalScrollController.addListener(_onHerbalScroll);
    _authorScrollController.addListener(_onAuthorScroll);
  }

  @override
  bool get wantKeepAlive => true;

  void _onHerbalScroll() {
    if (_isDisposed) return;
    if (_herbalScrollController.position.pixels >=
        _herbalScrollController.position.maxScrollExtent - 200) {
      final herbalBloc = context.read<HerbalBloc>();
      final state = herbalBloc.state;

      if (state is HerbalLoaded &&
          !state.hasReachedMax &&
          !state.isLoadingMore &&
          !_isDisposed) {
        herbalBloc.add(LoadMoreHerbalsEvent());
      }
    }
  }

  void _onAuthorScroll() {
    if (_isDisposed) return;
    if (_authorScrollController.position.pixels >=
        _authorScrollController.position.maxScrollExtent - 200) {
      final authorBloc = context.read<AuthorBloc>();
      final state = authorBloc.state;

      if (state is AuthorLoaded &&
          !state.hasReachedMax &&
          !state.isLoadingMore &&
          !_isDisposed) {
        authorBloc.add(LoadMoreAuthorsEvent());
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _tabController.removeListener(_tabListener);
    _tabController.dispose();
    _herbalScrollController.removeListener(_onHerbalScroll);
    _herbalScrollController.dispose();
    _authorScrollController.removeListener(_onAuthorScroll);
    _authorScrollController.dispose();
    context.read<HerbalBloc>().add(ClearHerbalStateEvent());
    context.read<AuthorBloc>().add(ClearAuthorStateEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildHerbalTab(), _buildAuthorTab()],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.SIZE_12,
        vertical: AppDimens.SIZE_4,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
      ),
      child: TabBar(
        padding: EdgeInsets.zero,
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: AppColors.secondaryBrand,
          borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
        ),
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: AppDimens.SIZE_14,
          color: AppColors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: AppDimens.SIZE_14,
          color: AppColors.textDark,
        ),
        onTap: (value) => _tabController.animateTo(value),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.eco, size: AppDimens.SIZE_24),
                const SizedBox(width: AppDimens.SIZE_8),
                Text(AppLocalizations.current.herbal),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings, size: AppDimens.SIZE_24),
                const SizedBox(width: AppDimens.SIZE_8),
                Text(AppLocalizations.current.teacher),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHerbalTab() {
    return BlocBuilder<HerbalBloc, HerbalState>(
      builder: (context, state) {
        if (state is HerbalLoading) {
          return LoadingTemplate(message: AppLocalizations.current.loading);
        } else if (state is HerbalLoaded) {
          return _buildHerbalList(state.herbals);
        } else if (state is HerbalError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorTemplate(
                  onRetry: () {
                    context.read<HerbalBloc>().add(const GetHerbalsEvent());
                  },
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HerbalBloc>().add(
              const GetHerbalsEvent(isRefresh: true),
            );
          },
          child: Center(
            child: CustomTextLabel(
              AppLocalizations.current.noDataAvailable,
              color: AppColors.disabledGrey,
              fontSize: AppDimens.SIZE_14,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAuthorTab() {
    return BlocBuilder<AuthorBloc, AuthorState>(
      builder: (context, state) {
        if (state is AuthorLoading) {
          return LoadingTemplate(message: AppLocalizations.current.loading);
        } else if (state is AuthorLoaded) {
          return _buildAuthorList(state.authors);
        } else if (state is AuthorError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorTemplate(
                  onRetry: () {
                    context.read<AuthorBloc>().add(const GetAuthorsEvent());
                  },
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<AuthorBloc>().add(
              const GetAuthorsEvent(isRefresh: true),
            );
          },
          child: Center(
            child: CustomTextLabel(
              AppLocalizations.current.noDataAvailable,
              color: AppColors.disabledGrey,
              fontSize: AppDimens.SIZE_14,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHerbalList(List<HerbalModel> herbals) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HerbalBloc>().add(RefreshHerbalsEvent());
      },
      child: ListView.builder(
        controller: _herbalScrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_4,
        ),
        itemCount: herbals.length + 1,
        itemBuilder: (context, index) {
          if (index == herbals.length) {
            return const SizedBox.shrink();
          }

          final herbal = herbals[index];
          return CardRowItemWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LibraryDetailScreen(herbalData: herbal),
                ),
              );
            },
            title: herbal.title ?? AppLocalizations.current.noDataAvailable,
            thumbnail: herbal.thumbnail,
            createdAt: herbal.createdAt,
            summary: herbal.summary,
            margin: const EdgeInsets.only(bottom: AppDimens.SIZE_8),
          );
        },
      ),
    );
  }

  Widget _buildAuthorList(List<AuthorModel> authors) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<AuthorBloc>().add(const RefreshAuthorsEvent());
      },
      child: ListView.builder(
        controller: _authorScrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_4,
        ),
        itemCount: authors.length + 1,
        itemBuilder: (context, index) {
          if (index == authors.length) {
            return const SizedBox.shrink();
          }

          final author = authors[index];
          return CardRowItemWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailScreen(author: author),
                ),
              );
            },
            title: author.name ?? AppLocalizations.current.noDataAvailable,
            thumbnail: author.avatar ?? author.portrait,
            createdAt: author.createdAt?.toIso8601String(),
            margin: const EdgeInsets.only(bottom: AppDimens.SIZE_8),
            summary:
                author.biography ??
                author.career ??
                AppLocalizations.current.noDataAvailable,
            // listBottomAction: Row(
            //   children: [
            //     if (author.viewCount != null)
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           Row(
            //             children: [
            //               const Icon(Icons.visibility, size: AppDimens.SIZE_16),
            //               const SizedBox(width: AppDimens.SIZE_4),
            //               CustomTextLabel('${author.viewCount}'),
            //             ],
            //           ),
            //           const SizedBox(width: AppDimens.SIZE_16),
            //           if (author.likeCount != null)
            //             Row(
            //               children: [
            //                 const Icon(Icons.favorite, size: AppDimens.SIZE_16),
            //                 const SizedBox(width: AppDimens.SIZE_4),
            //                 CustomTextLabel('${author.likeCount}'),
            //               ],
            //             ),
            //         ],
            //       ),
            //   ],
            // ),
          );
        },
      ),
    );
  }
}
