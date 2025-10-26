import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/tip/tip_state.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/category_model.dart';
import 'package:sotaynamduoc/domain/repositories/tip_repository.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';

class TipCubit extends Cubit<BaseState> {
  final TipRepository repository;

  List<TipModel> tips = [];
  List<CategoryModel> categories = [];
  TipModel? currentTip;
  bool hasMore = true;
  int currentPage = 1;
  String? currentSearch;
  String? currentCategory;
  String? currentDifficulty;
  String? currentTargetAudience;

  TipCubit({required this.repository}) : super(InitState());

  // Get tip list
  void getTipList({
    int page = 1,
    int size = 10,
    String? search,
    String? category,
    String? difficulty,
    String? targetAudience,
    String? sortBy,
    String? sortOrder,
    bool refresh = false,
  }) async {
    try {
      if (refresh) {
        emit(LoadingState());
        tips.clear();
        currentPage = 1;
        hasMore = true;
      } else if (page == 1) {
        emit(LoadingState());
      }
      currentSearch = search;
      currentCategory = category;
      currentDifficulty = difficulty;
      currentTargetAudience = targetAudience;

      final newTips = await repository.getTipList(
        page: page,
        size: size,
        search: search,
        category: category,
        difficulty: difficulty,
        targetAudience: targetAudience,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );

      if (page == 1) {
        tips = newTips;
      } else {
        tips.addAll(newTips);
      }

      currentPage = page;
      hasMore = newTips.length >= size;

      emit(LoadedState(tips));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Load more tips
  void loadMoreTips() {
    if (hasMore && state is! TipLoading) {
      getTipList(
        page: currentPage + 1,
        search: currentSearch,
        category: currentCategory,
        difficulty: currentDifficulty,
        targetAudience: currentTargetAudience,
      );
    }
  }

  // Get tip detail
  void getTipDetail(String tipId) async {
    try {
      emit(LoadingState());
      currentTip = await repository.getTipDetail(tipId);
      if (currentTip != null) {
        emit(LoadedState(currentTip!));
      } else {
        emit(ErrorState('Không tìm thấy tip'));
      }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Get categories
  void getTipCategories() async {
    try {
      emit(LoadingState());
      categories = await repository.getTipCategories();
      emit(LoadedState(categories));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Get related tips
  void getRelatedTips(String tipId, {int limit = 5}) async {
    try {
      emit(LoadingState());
      final relatedTips = await repository.getRelatedTips(tipId, limit: limit);
      emit(LoadedState(relatedTips));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Get popular tips
  void getPopularTips({int limit = 10}) async {
    try {
      emit(LoadingState());
      final popularTips = await repository.getPopularTips(limit: limit);
      emit(LoadedState(popularTips));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Get recent tips
  void getRecentTips({int limit = 10}) async {
    try {
      emit(LoadingState());
      final recentTips = await repository.getRecentTips(limit: limit);
      emit(LoadedState(recentTips));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Get bookmarked tips
  void getBookmarkedTips({int page = 1, int size = 10}) async {
    try {
      emit(LoadingState());
      // final bookmarkedTips = await repository.getBookmarkedTips(
      //   page: page,
      //   size: size,
      // );
      // emit(LoadedState(bookmarkedTips));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Search tips
  void searchTips({
    required String query,
    int page = 1,
    int size = 10,
    String? category,
    List<String>? tags,
  }) async {
    try {
      emit(LoadingState());
      // final searchResults = await repository.searchTips(
      //   query: query,
      //   page: page,
      //   size: size,
      //   category: category,
      //   tags: tags,
      // );
      // emit(LoadedState(searchResults));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Like tip
  void likeTip(String tipId) async {
    try {
      // final success = await repository.likeTip(tipId);
      // if (success) {
      //   // Update local state
      //   final tipIndex = tips.indexWhere((tip) => tip.id == tipId);
      //   if (tipIndex != -1) {
      //     final updatedTip = tips[tipIndex].copyWith(
      //       isLiked: true,
      //       likeCount: (tips[tipIndex].likeCount ?? 0) + 1,
      //     );
      //     tips[tipIndex] = updatedTip;
      //     emit(LoadedTipListState(tips));
      //   }

      //   if (currentTip?.id == tipId) {
      //     currentTip = currentTip!.copyWith(
      //       isLiked: true,
      //       likeCount: (currentTip!.likeCount ?? 0) + 1,
      //     );
      //     emit(LoadedTipDetailState(currentTip!));
      //   }
      // }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Unlike tip
  void unlikeTip(String tipId) async {
    try {
      // final success = await repository.unlikeTip(tipId);
      // if (success) {
      //   // Update local state
      //   final tipIndex = tips.indexWhere((tip) => tip.id == tipId);
      //   if (tipIndex != -1) {
      //     final updatedTip = tips[tipIndex].copyWith(
      //       isLiked: false,
      //       likeCount: (tips[tipIndex].likeCount ?? 1) - 1,
      //     );
      //     tips[tipIndex] = updatedTip;
      //     emit(LoadedTipListState(tips));
      //   }

      //   if (currentTip?.id == tipId) {
      //     currentTip = currentTip!.copyWith(
      //       isLiked: false,
      //       likeCount: (currentTip!.likeCount ?? 1) - 1,
      //     );
      //     emit(LoadedTipDetailState(currentTip!));
      //   }
      // }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Bookmark tip
  void bookmarkTip(String tipId) async {
    try {
      // final success = await repository.bookmarkTip(tipId);
      // if (success) {
      //   // Update local state
      //   final tipIndex = tips.indexWhere((tip) => tip.id == tipId);
      //   if (tipIndex != -1) {
      //     final updatedTip = tips[tipIndex].copyWith(
      //       isBookmarked: true,
      //       bookmarkCount: (tips[tipIndex].bookmarkCount ?? 0) + 1,
      //     );
      //     tips[tipIndex] = updatedTip;
      //     emit(LoadedTipListState(tips));
      //   }

      //   if (currentTip?.id == tipId) {
      //     currentTip = currentTip!.copyWith(
      //       isBookmarked: true,
      //       bookmarkCount: (currentTip!.bookmarkCount ?? 0) + 1,
      //     );
      //     emit(LoadedTipDetailState(currentTip!));
      //   }
      // }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Unbookmark tip
  void unbookmarkTip(String tipId) async {
    try {
      // final success = await repository.unbookmarkTip(tipId);
      // if (success) {
      //   // Update local state
      //   final tipIndex = tips.indexWhere((tip) => tip.id == tipId);
      //   if (tipIndex != -1) {
      //     final updatedTip = tips[tipIndex].copyWith(
      //       isBookmarked: false,
      //       bookmarkCount: (tips[tipIndex].bookmarkCount ?? 1) - 1,
      //     );
      //     tips[tipIndex] = updatedTip;
      //     emit(LoadedTipListState(tips));
      //   }

      //   if (currentTip?.id == tipId) {
      //     currentTip = currentTip!.copyWith(
      //       isBookmarked: false,
      //       bookmarkCount: (currentTip!.bookmarkCount ?? 1) - 1,
      //     );
      //     emit(LoadedTipDetailState(currentTip!));
      //   }
      // }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Share tip
  void shareTip(String tipId, {String? platform}) async {
    try {
      // final success = await repository.shareTip(tipId, platform: platform);
      // if (success) {
      //   emit(TipSharedState());
      // }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  // Reset state
  void resetState() {
    tips.clear();
    categories.clear();
    currentTip = null;
    hasMore = true;
    currentPage = 1;
    currentSearch = null;
    currentCategory = null;
    currentDifficulty = null;
    currentTargetAudience = null;
    emit(InitState());
  }
}
