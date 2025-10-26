import 'package:equatable/equatable.dart';

abstract class TipEvent extends Equatable {
  const TipEvent();

  @override
  List<Object?> get props => [];
}

class LoadTipList extends TipEvent {
  final int page;
  final int size;
  final String? search;
  final String? categoryId;
  final String? difficulty;
  final String? targetAudience;
  final bool isRefresh;

  const LoadTipList({
    this.page = 1,
    this.size = 10,
    this.search,
    this.categoryId,
    this.difficulty,
    this.targetAudience,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [
    page,
    size,
    search,
    categoryId,
    difficulty,
    targetAudience,
    isRefresh,
  ];
}

class LoadTipDetail extends TipEvent {
  final String id;

  const LoadTipDetail(this.id);

  @override
  List<Object> get props => [id];
}

class SearchTip extends TipEvent {
  final String searchTerm;

  const SearchTip(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class RefreshTip extends TipEvent {
  const RefreshTip();
}

class UpdateTipView extends TipEvent {
  final String id;

  const UpdateTipView(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTipLike extends TipEvent {
  final String id;

  const UpdateTipLike(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateTipBookmark extends TipEvent {
  final String id;

  const UpdateTipBookmark(this.id);

  @override
  List<Object> get props => [id];
}
