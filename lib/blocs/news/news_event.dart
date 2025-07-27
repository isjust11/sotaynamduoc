import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNewsList extends NewsEvent {
  final int page;
  final int size;
  final String? search;
  final bool isRefresh;

  const LoadNewsList({
    this.page = 1,
    this.size = 10,
    this.search,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [page, size, search ?? '', isRefresh];
}

class LoadNewsDetail extends NewsEvent {
  final String id;

  const LoadNewsDetail(this.id);

  @override
  List<Object> get props => [id];
}

class SearchNews extends NewsEvent {
  final String searchTerm;

  const SearchNews(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class RefreshNews extends NewsEvent {
  const RefreshNews();
}
