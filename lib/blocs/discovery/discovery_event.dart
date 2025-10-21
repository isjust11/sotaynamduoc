import 'package:equatable/equatable.dart';

abstract class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object> get props => [];
}

class LoadDiscoveryData extends DiscoveryEvent {
  const LoadDiscoveryData();
}

class LoadFeaturedContent extends DiscoveryEvent {
  const LoadFeaturedContent();
}

class LoadTrendingContent extends DiscoveryEvent {
  const LoadTrendingContent();
}

class LoadRecommendedContent extends DiscoveryEvent {
  const LoadRecommendedContent();
}

class SearchDiscovery extends DiscoveryEvent {
  final String searchTerm;

  const SearchDiscovery(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class RefreshDiscovery extends DiscoveryEvent {
  const RefreshDiscovery();
}

class UpdateContentLike extends DiscoveryEvent {
  final String contentId;
  final bool isLiked;

  const UpdateContentLike({required this.contentId, required this.isLiked});

  @override
  List<Object> get props => [contentId, isLiked];
}

class UpdateContentBookmark extends DiscoveryEvent {
  final String contentId;
  final bool isBookmarked;

  const UpdateContentBookmark({
    required this.contentId,
    required this.isBookmarked,
  });

  @override
  List<Object> get props => [contentId, isBookmarked];
}

class UpdateContentView extends DiscoveryEvent {
  final String contentId;

  const UpdateContentView(this.contentId);

  @override
  List<Object> get props => [contentId];
}

class LoadCategoryContent extends DiscoveryEvent {
  final String categoryId;

  const LoadCategoryContent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class LoadQuickActionContent extends DiscoveryEvent {
  final String actionType; // 'trending', 'favorites', 'recent', 'bookmarks'

  const LoadQuickActionContent(this.actionType);

  @override
  List<Object> get props => [actionType];
}
