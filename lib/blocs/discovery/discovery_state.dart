import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

abstract class DiscoveryState extends Equatable {
  const DiscoveryState();

  @override
  List<Object> get props => [];
}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class DiscoveryDataLoaded extends DiscoveryState {
  final List<NewsModel> featuredItems;
  final List<NewsModel> trendingItems;
  final List<NewsModel> recommendedItems;
  final List<NewsModel> searchResults;
  final String? searchTerm;
  final bool isSearching;

  const DiscoveryDataLoaded({
    required this.featuredItems,
    required this.trendingItems,
    required this.recommendedItems,
    this.searchResults = const [],
    this.searchTerm,
    this.isSearching = false,
  });

  @override
  List<Object> get props => [
    featuredItems,
    trendingItems,
    recommendedItems,
    searchResults,
    searchTerm ?? '',
    isSearching,
  ];

  DiscoveryDataLoaded copyWith({
    List<NewsModel>? featuredItems,
    List<NewsModel>? trendingItems,
    List<NewsModel>? recommendedItems,
    List<NewsModel>? searchResults,
    String? searchTerm,
    bool? isSearching,
  }) {
    return DiscoveryDataLoaded(
      featuredItems: featuredItems ?? this.featuredItems,
      trendingItems: trendingItems ?? this.trendingItems,
      recommendedItems: recommendedItems ?? this.recommendedItems,
      searchResults: searchResults ?? this.searchResults,
      searchTerm: searchTerm ?? this.searchTerm,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

class DiscoverySearchLoaded extends DiscoveryState {
  final List<NewsModel> searchResults;
  final String searchTerm;

  const DiscoverySearchLoaded({
    required this.searchResults,
    required this.searchTerm,
  });

  @override
  List<Object> get props => [searchResults, searchTerm];
}

class DiscoveryCategoryLoaded extends DiscoveryState {
  final List<NewsModel> categoryItems;
  final String categoryId;

  const DiscoveryCategoryLoaded({
    required this.categoryItems,
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryItems, categoryId];
}

class DiscoveryQuickActionLoaded extends DiscoveryState {
  final List<NewsModel> actionItems;
  final String actionType;

  const DiscoveryQuickActionLoaded({
    required this.actionItems,
    required this.actionType,
  });

  @override
  List<Object> get props => [actionItems, actionType];
}

class QuickActionDataLoaded extends DiscoveryState {
  final List<NewsModel> items;
  final String actionType;
  final bool isLoadMore;

  const QuickActionDataLoaded({
    required this.items,
    required this.actionType,
    this.isLoadMore = false,
  });

  @override
  List<Object> get props => [items, actionType, isLoadMore];
}

class DiscoveryError extends DiscoveryState {
  final String message;

  const DiscoveryError(this.message);

  @override
  List<Object> get props => [message];
}

class DiscoveryEmpty extends DiscoveryState {
  final String message;

  const DiscoveryEmpty({this.message = 'Không có dữ liệu nào'});

  @override
  List<Object> get props => [message];
}

class DiscoveryContentUpdated extends DiscoveryState {
  final String contentId;
  final bool isLiked;
  final bool isBookmarked;
  final int viewCount;

  const DiscoveryContentUpdated({
    required this.contentId,
    required this.isLiked,
    required this.isBookmarked,
    required this.viewCount,
  });

  @override
  List<Object> get props => [contentId, isLiked, isBookmarked, viewCount];
}
