import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsListLoaded extends NewsState {
  final List<NewsModel> newsList;
  final bool hasMore;
  final bool isLoadingMore;
  final String? searchTerm;

  const NewsListLoaded({
    required this.newsList,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchTerm,
  });

  @override
  List<Object> get props => [
    newsList,
    hasMore,
    isLoadingMore,
    searchTerm ?? '',
  ];

  NewsListLoaded copyWith({
    List<NewsModel>? newsList,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchTerm,
  }) {
    return NewsListLoaded(
      newsList: newsList ?? this.newsList,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class NewsDetailLoaded extends NewsState {
  final NewsModel news;

  const NewsDetailLoaded(this.news);

  @override
  List<Object> get props => [news];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}

class NewsEmpty extends NewsState {
  final String message;

  const NewsEmpty({this.message = 'Không có tin tức nào'});

  @override
  List<Object> get props => [message];
}
