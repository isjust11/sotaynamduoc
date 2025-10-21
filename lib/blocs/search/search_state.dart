import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuggestionsLoaded extends SearchState {
  final List<String> suggestions;
  final List<String> searchHistory;
  final bool isSearching;

  const SearchSuggestionsLoaded({
    required this.suggestions,
    required this.searchHistory,
    this.isSearching = false,
  });

  @override
  List<Object> get props => [suggestions, searchHistory, isSearching];

  SearchSuggestionsLoaded copyWith({
    List<String>? suggestions,
    List<String>? searchHistory,
    bool? isSearching,
  }) {
    return SearchSuggestionsLoaded(
      suggestions: suggestions ?? this.suggestions,
      searchHistory: searchHistory ?? this.searchHistory,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class SearchResultsLoaded extends SearchState {
  final List<Map<String, dynamic>> searchResults;
  final String searchQuery;
  final bool hasMore;
  final bool isLoadingMore;
  final List<String> searchHistory;

  const SearchResultsLoaded({
    required this.searchResults,
    required this.searchQuery,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchHistory = const [],
  });

  @override
  List<Object> get props => [
    searchResults,
    searchQuery,
    hasMore,
    isLoadingMore,
    searchHistory,
  ];

  SearchResultsLoaded copyWith({
    List<Map<String, dynamic>>? searchResults,
    String? searchQuery,
    bool? hasMore,
    bool? isLoadingMore,
    List<String>? searchHistory,
  }) {
    return SearchResultsLoaded(
      searchResults: searchResults ?? this.searchResults,
      searchQuery: searchQuery ?? this.searchQuery,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }
}

class SearchEmpty extends SearchState {
  final String message;
  final String searchQuery;
  final List<String> searchHistory;

  const SearchEmpty({
    this.message = 'Không tìm thấy kết quả nào',
    required this.searchQuery,
    this.searchHistory = const [],
  });

  @override
  List<Object> get props => [message, searchQuery, searchHistory];
}

class SearchError extends SearchState {
  final String message;
  final String? searchQuery;

  const SearchError(this.message, {this.searchQuery});

  @override
  List<Object> get props => [message, searchQuery ?? ''];
}

class SearchHistoryUpdated extends SearchState {
  final List<String> searchHistory;

  const SearchHistoryUpdated(this.searchHistory);

  @override
  List<Object> get props => [searchHistory];
}
