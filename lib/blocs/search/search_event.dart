import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitialized extends SearchEvent {
  const SearchInitialized();
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  final String query;

  const SearchSubmitted(this.query);

  @override
  List<Object> get props => [query];
}

class SearchCleared extends SearchEvent {
  const SearchCleared();
}

class LoadSearchHistory extends SearchEvent {
  const LoadSearchHistory();
}

class AddToSearchHistory extends SearchEvent {
  final String query;

  const AddToSearchHistory(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearchHistory extends SearchEvent {
  const ClearSearchHistory();
}

class LoadSearchSuggestions extends SearchEvent {
  const LoadSearchSuggestions();
}

class SearchSuggestionTapped extends SearchEvent {
  final String suggestion;

  const SearchSuggestionTapped(this.suggestion);

  @override
  List<Object> get props => [suggestion];
}

class SearchHistoryTapped extends SearchEvent {
  final String historyItem;

  const SearchHistoryTapped(this.historyItem);

  @override
  List<Object> get props => [historyItem];
}

class SearchResultTapped extends SearchEvent {
  final Map<String, dynamic> result;

  const SearchResultTapped(this.result);

  @override
  List<Object> get props => [result];
}

class RefreshSearch extends SearchEvent {
  const RefreshSearch();
}

class LoadMoreSearchResults extends SearchEvent {
  const LoadMoreSearchResults();
}
