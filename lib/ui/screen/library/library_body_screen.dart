import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/herbal/herbal.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/colors.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/ui/screen/library/detail/library_detail_screen.dart';
import 'package:sotaynamduoc/ui/widget/card_item.dart';
import 'package:sotaynamduoc/ui/widget/custom_text_label.dart';

class LibraryBodyScreen extends StatefulWidget {
  const LibraryBodyScreen({super.key});

  @override
  State<LibraryBodyScreen> createState() => _LibraryBodyScreenState();
}

class _LibraryBodyScreenState extends State<LibraryBodyScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    context.read<HerbalBloc>().add(const GetHerbalsEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isDisposed) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final herbalBloc = context.read<HerbalBloc>();
      final state = herbalBloc.state;
      
      // Chỉ load more nếu đang ở trạng thái loaded, chưa đạt giới hạn và không đang loading
      if (state is HerbalLoaded && 
          !state.hasReachedMax && 
          !state.isLoadingMore && 
          !_isDisposed) {
        herbalBloc.add(LoadMoreHerbalsEvent());
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<HerbalBloc, HerbalState>(
      builder: (context, state) {
        if (state is HerbalLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HerbalLoaded) {
          return _buildHerbalList(state.herbals);
        } else if (state is HerbalError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<HerbalBloc>().add(const GetHerbalsEvent());
                  },
                  child: CustomTextLabel(AppLocalizations.current.retry, color: AppColors.white, fontSize: AppDimens.SIZE_14),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<HerbalBloc>().add(const GetHerbalsEvent(isRefresh: true));
          },
          child: Center(
            child: CustomTextLabel(AppLocalizations.current.noDataAvailable, color: AppColors.disabledGrey, fontSize: AppDimens.SIZE_14),
          ),
        );
      },
    );
  }

    Widget _buildHerbalList(List<HerbalModel> herbals) {
    if (herbals.isEmpty) {
      return const Center(
        child: Text('No herbals found'),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HerbalBloc>().add(RefreshHerbalsEvent());
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.SIZE_16,
          vertical: AppDimens.SIZE_4,
        ),
        itemCount: herbals.length + 1, // +1 cho loading indicator
        itemBuilder: (context, index) {
          // Hiển thị loading indicator ở cuối danh sách
          if (index == herbals.length) {
            return BlocBuilder<HerbalBloc, HerbalState>(
              builder: (context, state) {
                if (state is HerbalLoaded && state.isLoadingMore) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          }
        final herbal = herbals[index];
        return CardItem(
          onTap: () {
            // Navigate to herbal detail screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LibraryDetailScreen(herbalData: herbal),
              ),
            );
          },
          title: herbal.title ?? 'No Title',
          thumbnail: herbal.thumbnail,
          createdAt: herbal.createdAt,
          summary: herbal.summary,
          listBottomAction: Row(
            children: [ 
              if (herbal.viewCount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.visibility, size: AppDimens.SIZE_16),
                        const SizedBox(width: AppDimens.SIZE_4),
                        Text('${herbal.viewCount}'),
                      ],
                    ),
                    const SizedBox(width: AppDimens.SIZE_16),
                    if (herbal.likeCount != null)
                      Row(
                        children: [
                          const Icon(Icons.favorite, size: AppDimens.SIZE_16),
                          const SizedBox(width: AppDimens.SIZE_4),
                          Text('${herbal.likeCount}'),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}