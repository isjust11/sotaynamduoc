import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/domain/repositories/herbal_repository.dart';
import 'package:sotaynamduoc/domain/repositories/folk_medicine_repository.dart';
import 'package:sotaynamduoc/blocs/search/search_event.dart';
import 'package:sotaynamduoc/blocs/search/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NewsRepository newsRepository;
  final HerbalRepository herbalRepository;
  final FolkMedicineRepository folkMedicineRepository;
  final SharedPreferences sharedPreferences;

  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentSearchQuery;

  // Constants
  static const String _searchHistoryKey = 'search_history';
  static const int _maxHistoryItems = 10;
  static const int _searchPageSize = 20;

  SearchBloc({
    required this.newsRepository,
    required this.herbalRepository,
    required this.folkMedicineRepository,
    required this.sharedPreferences,
  }) : super(SearchInitial()) {
    on<SearchInitialized>(_onSearchInitialized);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<SearchSubmitted>(_onSearchSubmitted);
    on<SearchCleared>(_onSearchCleared);
    on<LoadSearchHistory>(_onLoadSearchHistory);
    on<AddToSearchHistory>(_onAddToSearchHistory);
    on<ClearSearchHistory>(_onClearSearchHistory);
    on<LoadSearchSuggestions>(_onLoadSearchSuggestions);
    on<SearchSuggestionTapped>(_onSearchSuggestionTapped);
    on<SearchHistoryTapped>(_onSearchHistoryTapped);
    on<SearchResultTapped>(_onSearchResultTapped);
    on<RefreshSearch>(_onRefreshSearch);
    on<LoadMoreSearchResults>(_onLoadMoreSearchResults);
  }

  Future<void> _onSearchInitialized(
    SearchInitialized event,
    Emitter<SearchState> emit,
  ) async {
    try {
      emit(SearchLoading());

      // Load search history and suggestions
      final searchHistory = await _loadSearchHistory();
      final suggestions = _getSearchSuggestions();

      emit(
        SearchSuggestionsLoaded(
          suggestions: suggestions,
          searchHistory: searchHistory,
        ),
      );
    } catch (e) {
      emit(SearchError('Không thể khởi tạo tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      // If query is empty, show suggestions and history
      add(const LoadSearchSuggestions());
      return;
    }

    // Show loading state while typing
    if (state is SearchSuggestionsLoaded) {
      final currentState = state as SearchSuggestionsLoaded;
      emit(currentState.copyWith(isSearching: true));
    }
  }

  Future<void> _onSearchSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) return;

    try {
      emit(SearchLoading());

      // Reset pagination
      _currentPage = 1;
      _hasMore = true;
      _currentSearchQuery = event.query;

      // Add to search history
      add(AddToSearchHistory(event.query));

      // Perform search
      final searchResults = await _performSearch(event.query, 1);

      if (searchResults.isEmpty) {
        final searchHistory = await _loadSearchHistory();
        emit(
          SearchEmpty(searchQuery: event.query, searchHistory: searchHistory),
        );
      } else {
        final searchHistory = await _loadSearchHistory();
        emit(
          SearchResultsLoaded(
            searchResults: searchResults,
            searchQuery: event.query,
            hasMore: searchResults.length >= _searchPageSize,
            searchHistory: searchHistory,
          ),
        );
      }
    } catch (e) {
      emit(SearchError('Không thể tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onSearchCleared(
    SearchCleared event,
    Emitter<SearchState> emit,
  ) async {
    _currentSearchQuery = null;
    _currentPage = 1;
    _hasMore = true;

    add(const LoadSearchSuggestions());
  }

  Future<void> _onLoadSearchHistory(
    LoadSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final searchHistory = await _loadSearchHistory();
      emit(SearchHistoryUpdated(searchHistory));
    } catch (e) {
      emit(SearchError('Không thể tải lịch sử tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onAddToSearchHistory(
    AddToSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final currentHistory = await _loadSearchHistory();

      // Remove if already exists
      currentHistory.remove(event.query);

      // Add to beginning
      currentHistory.insert(0, event.query);

      // Keep only max items
      if (currentHistory.length > _maxHistoryItems) {
        currentHistory.removeRange(_maxHistoryItems, currentHistory.length);
      }

      // Save to SharedPreferences
      await sharedPreferences.setStringList(_searchHistoryKey, currentHistory);

      emit(SearchHistoryUpdated(currentHistory));
    } catch (e) {
      // Don't emit error for history update failure
    }
  }

  Future<void> _onClearSearchHistory(
    ClearSearchHistory event,
    Emitter<SearchState> emit,
  ) async {
    try {
      await sharedPreferences.remove(_searchHistoryKey);
      emit(const SearchHistoryUpdated([]));
    } catch (e) {
      emit(SearchError('Không thể xóa lịch sử tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onLoadSearchSuggestions(
    LoadSearchSuggestions event,
    Emitter<SearchState> emit,
  ) async {
    try {
      final searchHistory = await _loadSearchHistory();
      final suggestions = _getSearchSuggestions();

      emit(
        SearchSuggestionsLoaded(
          suggestions: suggestions,
          searchHistory: searchHistory,
        ),
      );
    } catch (e) {
      emit(SearchError('Không thể tải gợi ý tìm kiếm: ${e.toString()}'));
    }
  }

  Future<void> _onSearchSuggestionTapped(
    SearchSuggestionTapped event,
    Emitter<SearchState> emit,
  ) async {
    add(SearchSubmitted(event.suggestion));
  }

  Future<void> _onSearchHistoryTapped(
    SearchHistoryTapped event,
    Emitter<SearchState> emit,
  ) async {
    add(SearchSubmitted(event.historyItem));
  }

  Future<void> _onSearchResultTapped(
    SearchResultTapped event,
    Emitter<SearchState> emit,
  ) async {
    // TODO: Navigate to detail page based on result type
    // This would typically trigger navigation
  }

  Future<void> _onRefreshSearch(
    RefreshSearch event,
    Emitter<SearchState> emit,
  ) async {
    if (_currentSearchQuery != null) {
      add(SearchSubmitted(_currentSearchQuery!));
    } else {
      add(const LoadSearchSuggestions());
    }
  }

  Future<void> _onLoadMoreSearchResults(
    LoadMoreSearchResults event,
    Emitter<SearchState> emit,
  ) async {
    if (!_hasMore || _currentSearchQuery == null) return;

    if (state is SearchResultsLoaded) {
      final currentState = state as SearchResultsLoaded;
      if (currentState.isLoadingMore) return;

      try {
        emit(currentState.copyWith(isLoadingMore: true));

        final nextPage = _currentPage + 1;
        final moreResults = await _performSearch(
          _currentSearchQuery!,
          nextPage,
        );

        if (moreResults.isEmpty) {
          _hasMore = false;
          emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
        } else {
          _currentPage = nextPage;
          _hasMore = moreResults.length >= _searchPageSize;

          final updatedResults = [
            ...currentState.searchResults,
            ...moreResults,
          ];
          emit(
            currentState.copyWith(
              searchResults: updatedResults,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        }
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
        emit(SearchError('Không thể tải thêm kết quả: ${e.toString()}'));
      }
    }
  }

  // Helper methods
  Future<List<String>> _loadSearchHistory() async {
    try {
      return sharedPreferences.getStringList(_searchHistoryKey) ?? [];
    } catch (e) {
      return [];
    }
  }

  List<String> _getSearchSuggestions() {
    return [
      'Nhân sâm',
      'Nấm linh chi',
      'Đông trùng hạ thảo',
      'Hoàng kỳ',
      'Bạch truật',
      'Cam thảo',
      'Sinh địa',
      'Đương quy',
      'Bạch thược',
      'Xuyên khung',
      'Bài thuốc cảm cúm',
      'Cách sử dụng dược liệu',
      'Dược liệu quý hiếm',
      'Thảo dược thiên nhiên',
    ];
  }

  Future<List<Map<String, dynamic>>> _performSearch(
    String query,
    int page,
  ) async {
    try {
      final results = <Map<String, dynamic>>[];

      // Search in news/articles
      try {
        final newsResults = await newsRepository.getNewsList(
          page: page,
          size: _searchPageSize,
          search: query,
        );

        for (final news in newsResults) {
          results.add({
            'id': news.id,
            'title': news.title,
            'description': news.summary ?? '',
            'type': 'Bài viết',
            'image': news.thumbnail ?? '',
            'views': news.view ?? 0,
            'likes': news.like ?? 0,
            'author': news.author?.name ?? 'Tác giả',
            'publishDate':
                news.createdAt?.toIso8601String().split('T')[0] ?? '',
            'category': news.category?.name ?? 'Tin tức',
            'data': news,
          });
        }
      } catch (e) {
        // Continue with other searches if news search fails
      }

      // Search in herbs
      try {
        final herbalResults = await herbalRepository.getHerbals(
          page: page,
          limit: _searchPageSize,
          search: query,
        );

        for (final herbal in herbalResults) {
          results.add({
            'id': herbal.id,
            'title': herbal.title ?? '',
            'description': herbal.summary ?? '',
            'type': 'Thảo dược',
            'image': herbal.thumbnail ?? '',
            'views': herbal.viewCount ?? 0,
            'likes': herbal.likeCount ?? 0,
            'author': 'Hệ thống',
            'publishDate': herbal.createdAt?.split('T')[0] ?? '',
            'category': herbal.categoryName ?? 'Thảo dược',
            'data': herbal,
          });
        }
      } catch (e) {
        // Continue with other searches if herbal search fails
      }

      // Search in folk medicines
      try {
        final folkMedicineResults = await folkMedicineRepository
            .getFolkMedicines(
              page: page,
              limit: _searchPageSize,
              search: query,
            );

        for (final folkMedicine in folkMedicineResults) {
          results.add({
            'id': folkMedicine.id,
            'title': folkMedicine.title ?? '',
            'description': folkMedicine.summary ?? '',
            'type': 'Bài thuốc',
            'image': folkMedicine.thumbnail ?? '',
            'views': folkMedicine.viewCount ?? 0,
            'likes': folkMedicine.likeCount ?? 0,
            'author': 'Hệ thống',
            'publishDate': folkMedicine.createdAt?.split('T')[0] ?? '',
            'category': folkMedicine.category?.name ?? 'Bài thuốc',
            'data': folkMedicine,
          });
        }
      } catch (e) {
        // Continue with other searches if folk medicine search fails
      }

      return results;
    } catch (e) {
      // Return mock data if all searches fail
      return _getMockSearchResults(query);
    }
  }

  List<Map<String, dynamic>> _getMockSearchResults(String query) {
    return [
      {
        'id': '1',
        'title': 'Nhân sâm Hàn Quốc - Công dụng và cách sử dụng',
        'description':
            'Nhân sâm có tác dụng bồi bổ sức khỏe, tăng cường miễn dịch và cải thiện trí nhớ',
        'type': 'Thảo dược',
        'image': 'assets/images/placeholder.png',
        'views': 5420,
        'likes': 128,
        'author': 'Hệ thống',
        'publishDate': '2024-01-15',
        'category': 'Thảo dược quý',
      },
      {
        'id': '2',
        'title': 'Cách sử dụng nhân sâm hiệu quả',
        'description':
            'Hướng dẫn chi tiết cách sử dụng nhân sâm để đạt hiệu quả tốt nhất',
        'type': 'Bài viết',
        'image': 'assets/images/placeholder.png',
        'views': 3890,
        'likes': 95,
        'author': 'Chuyên gia dược liệu',
        'publishDate': '2024-01-12',
        'category': 'Hướng dẫn',
      },
      {
        'id': '3',
        'title': 'Bài thuốc với nhân sâm cho người cao tuổi',
        'description':
            'Các bài thuốc Đông y sử dụng nhân sâm phù hợp cho người cao tuổi',
        'type': 'Bài thuốc',
        'image': 'assets/images/placeholder.png',
        'views': 2100,
        'likes': 67,
        'author': 'Lương y',
        'publishDate': '2024-01-10',
        'category': 'Bài thuốc',
      },
    ];
  }

  // Public methods for external use
  void loadMore() {
    if (_hasMore && _currentSearchQuery != null) {
      add(const LoadMoreSearchResults());
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
  String? get currentSearchQuery => _currentSearchQuery;
}
