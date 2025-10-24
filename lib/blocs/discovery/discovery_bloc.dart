import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/domain/repositories/category_repository.dart';
import 'package:sotaynamduoc/domain/repositories/herbal_repository.dart';
import 'package:sotaynamduoc/domain/repositories/author_repository.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery_event.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery_state.dart';

import '../../domain/data/models/models.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final NewsRepository newsRepository;
  final CategoryRepository categoryRepository;
  final HerbalRepository herbalRepository;
  final AuthorRepository authorRepository;

  DiscoveryBloc({
    required this.newsRepository,
    required this.categoryRepository,
    required this.herbalRepository,
    required this.authorRepository,
  }) : super(DiscoveryInitial()) {
    on<LoadDiscoveryData>(_onLoadDiscoveryData);
    on<LoadFeaturedContent>(_onLoadFeaturedContent);
    on<LoadTrendingContent>(_onLoadTrendingContent);
    on<LoadRecommendedContent>(_onLoadRecommendedContent);
    on<SearchDiscovery>(_onSearchDiscovery);
    on<RefreshDiscovery>(_onRefreshDiscovery);
    on<UpdateContentLike>(_onUpdateContentLike);
    on<UpdateContentBookmark>(_onUpdateContentBookmark);
    on<UpdateContentView>(_onUpdateContentView);
    on<LoadCategoryContent>(_onLoadCategoryContent);
    on<LoadQuickActionContent>(_onLoadQuickActionContent);
  }

  Future<void> _onLoadDiscoveryData(
    LoadDiscoveryData event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      emit(DiscoveryLoading());

      // Load all discovery data in parallel
      final featuredFuture = _getFeaturedContent(event.page, event.pageSize);
      final trendingFuture = _getTrendingContent();
      final recommendedFuture = _getRecommendedContent(event.searchData ?? []);

      final results = await Future.wait([
        featuredFuture,
        trendingFuture,
        recommendedFuture,
      ]);

      final featuredItems = results[0];
      final trendingItems = results[1];
      final recommendedItems = results[2];

      emit(
        DiscoveryDataLoaded(
          featuredItems: featuredItems,
          trendingItems: trendingItems,
          recommendedItems: recommendedItems,
        ),
      );
    } catch (e) {
      emit(DiscoveryError('Không thể tải dữ liệu khám phá: ${e.toString()}'));
    }
  }

  Future<void> _onLoadFeaturedContent(
    LoadFeaturedContent event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      emit(DiscoveryLoading());
      final featuredItems = await _getFeaturedContent(1, 10);
      emit(
        DiscoveryDataLoaded(
          featuredItems: featuredItems,
          trendingItems: const [],
          recommendedItems: const [],
        ),
      );
    } catch (e) {
      emit(DiscoveryError('Không thể tải nội dung nổi bật: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTrendingContent(
    LoadTrendingContent event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      emit(DiscoveryLoading());
      final trendingItems = await _getTrendingContent();
      emit(
        DiscoveryDataLoaded(
          featuredItems: const [],
          trendingItems: trendingItems,
          recommendedItems: const [],
        ),
      );
    } catch (e) {
      emit(DiscoveryError('Không thể tải nội dung xu hướng: ${e.toString()}'));
    }
  }

  Future<void> _onLoadRecommendedContent(
    LoadRecommendedContent event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      emit(DiscoveryLoading());
      final recommendedItems = await _getRecommendedContent(
        event.searchData ?? [],
      );
      emit(
        DiscoveryDataLoaded(
          featuredItems: const [],
          trendingItems: const [],
          recommendedItems: recommendedItems,
        ),
      );
    } catch (e) {
      emit(DiscoveryError('Không thể tải nội dung gợi ý: ${e.toString()}'));
    }
  }

  Future<void> _onSearchDiscovery(
    SearchDiscovery event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      if (event.searchTerm.isEmpty) {
        // If search is empty, return to main discovery data
        add(LoadDiscoveryData(1, 10, searchData: event.searchTerm.split(' ')));
        return;
      }

      emit(DiscoveryLoading());

      // Search across different content types
      final searchResults = await _searchContent(event.searchTerm);

      if (searchResults.isEmpty) {
        emit(const DiscoveryEmpty(message: 'Không tìm thấy kết quả nào'));
      } else {
        emit(
          DiscoverySearchLoaded(
            searchResults: searchResults,
            searchTerm: event.searchTerm,
          ),
        );
      }
    } catch (e) {
      emit(DiscoveryError('Không thể tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshDiscovery(
    RefreshDiscovery event,
    Emitter<DiscoveryState> emit,
  ) async {
    add(LoadDiscoveryData(1, 10, searchData: []));
  }

  Future<void> _onUpdateContentLike(
    UpdateContentLike event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      // Update like status in repository
      if (event.isLiked) {
        await newsRepository.updateNewsLike(event.contentId);
      }

      // Emit updated state
      emit(
        DiscoveryContentUpdated(
          contentId: event.contentId,
          isLiked: event.isLiked,
          isBookmarked: false, // This would need to be tracked separately
          viewCount: 0, // This would need to be tracked separately
        ),
      );
    } catch (e) {
      emit(
        DiscoveryError(
          'Không thể cập nhật trạng thái yêu thích: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUpdateContentBookmark(
    UpdateContentBookmark event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      // Update bookmark status (this would need to be implemented in repository)
      // For now, just emit the updated state
      emit(
        DiscoveryContentUpdated(
          contentId: event.contentId,
          isLiked: false, // This would need to be tracked separately
          isBookmarked: event.isBookmarked,
          viewCount: 0, // This would need to be tracked separately
        ),
      );
    } catch (e) {
      emit(
        DiscoveryError(
          'Không thể cập nhật trạng thái đánh dấu: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> _onUpdateContentView(
    UpdateContentView event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      await newsRepository.updateNewsView(event.contentId);
    } catch (e) {
      emit(DiscoveryError('Không thể cập nhật lượt xem: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCategoryContent(
    LoadCategoryContent event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      emit(DiscoveryLoading());
      final categoryItems = await _getCategoryContent(event.categoryId);
      emit(
        DiscoveryCategoryLoaded(
          categoryItems: categoryItems,
          categoryId: event.categoryId,
        ),
      );
    } catch (e) {
      emit(DiscoveryError('Không thể tải nội dung danh mục: ${e.toString()}'));
    }
  }

  Future<void> _onLoadQuickActionContent(
    LoadQuickActionContent event,
    Emitter<DiscoveryState> emit,
  ) async {
    try {
      if (!event.isLoadMore) {
        emit(DiscoveryLoading());
      }

      final actionItems = await _getQuickActionContentWithPagination(
        event.actionType,
        event.page,
        event.pageSize,
      );

      emit(
        QuickActionDataLoaded(
          items: actionItems,
          actionType: event.actionType,
          isLoadMore: event.isLoadMore,
        ),
      );
    } catch (e) {
      emit(
        DiscoveryError(
          'Không thể tải nội dung thao tác nhanh: ${e.toString()}',
        ),
      );
    }
  }

  // Helper methods to get data from repositories
  Future<List<NewsModel>> _getFeaturedContent(int page, int pageSize) async {
    try {
      // Get featured news/articles most viewed
      final newsList = await newsRepository.getFeaturedNewsList(page, pageSize);
      return newsList;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<NewsModel>> _getTrendingContent() async {
    try {
      // Get trending news/articles
      final newsList = await newsRepository.getTrendingNewsList();

      return newsList;
    } catch (e) {
      // Return mock data if API fails
      return [];
    }
  }

  Future<List<NewsModel>> _getRecommendedContent(
    List<String> searchData,
  ) async {
    try {
      // Get recommended content based on user preferences
      final newsList = await newsRepository.getRecommendedNewsList(searchData);
      return newsList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _searchContent(String searchTerm) async {
    try {
      // Search across different content types
      final newsResults = await newsRepository.getNewsList(
        page: 1,
        size: 20,
        search: searchTerm,
      );

      return newsResults;
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getCategoryContent(String categoryId) async {
    try {
      final newsList = await newsRepository.getNewsList(
        page: 1,
        size: 20,
        categoryId: categoryId,
      );

      return newsList;
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getQuickActionContentWithPagination(
    String actionType,
    int page,
    int pageSize,
  ) async {
    try {
      switch (actionType) {
        case 'trending':
          return await _getTrendingContentWithPagination(page, pageSize);
        case 'favorites':
          return await _getFavoriteContentWithPagination(page, pageSize);
        case 'recent':
          return await _getRecentContentWithPagination(page, pageSize);
        case 'bookmarks':
          return await _getBookmarkedContentWithPagination(page, pageSize);
        default:
          return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getTrendingContentWithPagination(
    int page,
    int pageSize,
  ) async {
    try {
      return await newsRepository.getTrendingList(page: page, size: pageSize);
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getFavoriteContentWithPagination(
    int page,
    int pageSize,
  ) async {
    try {
      return await newsRepository.getFavoriteList(page: page, size: pageSize);
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getRecentContentWithPagination(
    int page,
    int pageSize,
  ) async {
    try {
      return await newsRepository.getRecentList(page: page, size: pageSize);
    } catch (e) {
      return [];
    }
  }

  Future<List<NewsModel>> _getBookmarkedContentWithPagination(
    int page,
    int pageSize,
  ) async {
    try {
      return await newsRepository.getBookmarkedList(page: page, size: pageSize);
    } catch (e) {
      return [];
    }
  }
}
