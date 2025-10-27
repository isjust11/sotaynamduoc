import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';

abstract class TipState extends Equatable {
  const TipState();

  @override
  List<Object?> get props => [];
}

class TipInitial extends TipState {}

class TipLoading extends TipState {}

class TipListLoaded extends TipState {
  final List<TipModel> tipList;
  final bool hasMore;
  final bool isLoadingMore;
  final String? searchTerm;

  const TipListLoaded({
    required this.tipList,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchTerm,
  });

  TipListLoaded copyWith({
    List<TipModel>? tipList,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchTerm,
  }) {
    return TipListLoaded(
      tipList: tipList ?? this.tipList,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  List<Object?> get props => [tipList, hasMore, isLoadingMore, searchTerm];
}

class TipDetailLoaded extends TipState {
  final TipModel tip;

  TipDetailLoaded({required this.tip});

  TipDetailLoaded copyWith({TipModel? tip}) {
    return TipDetailLoaded(tip: tip ?? this.tip);
  }
}

class TipEmpty extends TipState {
  const TipEmpty();
}

class TipError extends TipState {
  final String message;

  const TipError(this.message);

  @override
  List<Object> get props => [message];
}
