import 'package:sotaynamduoc/blocs/base_bloc/base_state.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';

// Tip List States
class InitTipListState extends BaseState {}

class LoadingTipListState extends BaseState {}

class LoadingMoreTipListState extends BaseState {}

class LoadedTipListState extends BaseState {
  final List<TipModel> tips;

  const LoadedTipListState(this.tips);

  @override
  List<Object> get props => [tips];
}

class ErrorTipListState extends BaseState {
  final String message;

  const ErrorTipListState(this.message);

  @override
  List<Object> get props => [message];
}

// Tip Detail States
class LoadingTipDetailState extends BaseState {}

class LoadedTipDetailState extends BaseState {
  final TipModel tip;

  const LoadedTipDetailState(this.tip);

  @override
  List<Object> get props => [tip];
}

class ErrorTipDetailState extends BaseState {
  final String message;

  const ErrorTipDetailState(this.message);

  @override
  List<Object> get props => [message];
}

// Tip Categories States
class LoadingTipCategoriesState extends BaseState {}

class LoadedTipCategoriesState extends BaseState {
  final List<TipCategory> categories;

  const LoadedTipCategoriesState(this.categories);

  @override
  List<Object> get props => [categories];
}

class ErrorTipCategoriesState extends BaseState {
  final String message;

  const ErrorTipCategoriesState(this.message);

  @override
  List<Object> get props => [message];
}

// Related Tips States
class LoadingRelatedTipsState extends BaseState {}

class LoadedRelatedTipsState extends BaseState {
  final List<TipModel> relatedTips;

  const LoadedRelatedTipsState(this.relatedTips);

  @override
  List<Object> get props => [relatedTips];
}

class ErrorRelatedTipsState extends BaseState {
  final String message;

  const ErrorRelatedTipsState(this.message);

  @override
  List<Object> get props => [message];
}

// Popular Tips States
class LoadingPopularTipsState extends BaseState {}

class LoadedPopularTipsState extends BaseState {
  final List<TipModel> popularTips;

  const LoadedPopularTipsState(this.popularTips);

  @override
  List<Object> get props => [popularTips];
}

class ErrorPopularTipsState extends BaseState {
  final String message;

  const ErrorPopularTipsState(this.message);

  @override
  List<Object> get props => [message];
}

// Recent Tips States
class LoadingRecentTipsState extends BaseState {}

class LoadedRecentTipsState extends BaseState {
  final List<TipModel> recentTips;

  const LoadedRecentTipsState(this.recentTips);

  @override
  List<Object> get props => [recentTips];
}

class ErrorRecentTipsState extends BaseState {
  final String message;

  const ErrorRecentTipsState(this.message);

  @override
  List<Object> get props => [message];
}

// Bookmarked Tips States
class LoadingBookmarkedTipsState extends BaseState {}

class LoadedBookmarkedTipsState extends BaseState {
  final List<TipModel> bookmarkedTips;

  const LoadedBookmarkedTipsState(this.bookmarkedTips);

  @override
  List<Object> get props => [bookmarkedTips];
}

class ErrorBookmarkedTipsState extends BaseState {
  final String message;

  const ErrorBookmarkedTipsState(this.message);

  @override
  List<Object> get props => [message];
}

// Search Tips States
class LoadingSearchTipsState extends BaseState {}

class LoadedSearchTipsState extends BaseState {
  final List<TipModel> searchResults;

  const LoadedSearchTipsState(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}

class ErrorSearchTipsState extends BaseState {
  final String message;

  const ErrorSearchTipsState(this.message);

  @override
  List<Object> get props => [message];
}

// Tip Action States
class TipSharedState extends BaseState {}

class ErrorTipActionState extends BaseState {
  final String message;

  const ErrorTipActionState(this.message);

  @override
  List<Object> get props => [message];
}
