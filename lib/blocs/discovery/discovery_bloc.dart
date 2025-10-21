import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/domain/repositories/category_repository.dart';
import 'package:sotaynamduoc/domain/repositories/herbal_repository.dart';
import 'package:sotaynamduoc/domain/repositories/author_repository.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery_event.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery_state.dart';

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
      final featuredFuture = _getFeaturedContent();
      final trendingFuture = _getTrendingContent();
      final recommendedFuture = _getRecommendedContent();

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
      final featuredItems = await _getFeaturedContent();
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
      final recommendedItems = await _getRecommendedContent();
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
        add(const LoadDiscoveryData());
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
    add(const LoadDiscoveryData());
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
      emit(DiscoveryLoading());
      final actionItems = await _getQuickActionContent(event.actionType);
      emit(
        DiscoveryQuickActionLoaded(
          actionItems: actionItems,
          actionType: event.actionType,
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
  Future<List<Map<String, dynamic>>> _getFeaturedContent() async {
    try {
      // Get featured news/articles
      final newsList = await newsRepository.getNewsList(
        page: 1,
        size: 5,
        // Add featured filter if available
      );

      return newsList.map((news) => _convertNewsToMap(news)).toList();
    } catch (e) {
      // Return mock data if API fails
      return _getMockFeaturedContent();
    }
  }

  Future<List<Map<String, dynamic>>> _getTrendingContent() async {
    try {
      // Get trending news/articles
      final newsList = await newsRepository.getNewsList(
        page: 1,
        size: 10,
        // Add trending filter if available
      );

      return newsList.map((news) => _convertNewsToMap(news)).toList();
    } catch (e) {
      // Return mock data if API fails
      return _getMockTrendingContent();
    }
  }

  Future<List<Map<String, dynamic>>> _getRecommendedContent() async {
    try {
      // Get recommended content based on user preferences
      final newsList = await newsRepository.getNewsList(
        page: 1,
        size: 6,
        // Add recommendation filter if available
      );

      return newsList.map((news) => _convertNewsToMap(news)).toList();
    } catch (e) {
      // Return mock data if API fails
      return _getMockRecommendedContent();
    }
  }

  Future<List<Map<String, dynamic>>> _searchContent(String searchTerm) async {
    try {
      // Search across different content types
      final newsResults = await newsRepository.getNewsList(
        page: 1,
        size: 20,
        search: searchTerm,
      );

      return newsResults.map((news) => _convertNewsToMap(news)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _getCategoryContent(
    String categoryId,
  ) async {
    try {
      final newsList = await newsRepository.getNewsList(
        page: 1,
        size: 20,
        categoryId: categoryId,
      );

      return newsList.map((news) => _convertNewsToMap(news)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _getQuickActionContent(
    String actionType,
  ) async {
    try {
      switch (actionType) {
        case 'trending':
          return await _getTrendingContent();
        case 'favorites':
          // Get user's favorite content
          return await _getFavoriteContent();
        case 'recent':
          // Get recently viewed content
          return await _getRecentContent();
        case 'bookmarks':
          // Get bookmarked content
          return await _getBookmarkedContent();
        default:
          return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _getFavoriteContent() async {
    // This would need to be implemented based on user preferences
    return [];
  }

  Future<List<Map<String, dynamic>>> _getRecentContent() async {
    // This would need to be implemented based on user history
    return [];
  }

  Future<List<Map<String, dynamic>>> _getBookmarkedContent() async {
    // This would need to be implemented based on user bookmarks
    return [];
  }

  // Convert NewsModel to Map for UI
  Map<String, dynamic> _convertNewsToMap(dynamic news) {
    return {
      'id': news.id,
      'title': news.title,
      'summary': news.summary ?? '',
      'thumbnail': news.thumbnail ?? '',
      'type': news.category?.name ?? 'news',
      'views': news.viewCount ?? 0,
      'likes': news.likeCount ?? 0,
      'isLiked': false, // This would need to be tracked separately
      'isBookmarked': false, // This would need to be tracked separately
      'author': news.author?.name ?? 'Tác giả',
      'publishDate': news.createdAt?.toIso8601String().split('T')[0] ?? '',
    };
  }

  // Mock data methods (fallback when API fails)
  List<Map<String, dynamic>> _getMockFeaturedContent() {
    return [
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
    ];
  }

  List<Map<String, dynamic>> _getMockTrendingContent() {
    return [
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
    ];
  }

  List<Map<String, dynamic>> _getMockRecommendedContent() {
    return [
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
        ],
      },
    ];
  }
}
