import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

abstract class HerbalState extends Equatable {
  const HerbalState();

  @override
  List<Object> get props => [];
}

class HerbalInitial extends HerbalState {}

class HerbalLoading extends HerbalState {}

class HerbalLoaded extends HerbalState {
  final List<HerbalModel> herbals;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const HerbalLoaded({
    required this.herbals,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  HerbalLoaded copyWith({
    List<HerbalModel>? herbals,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return HerbalLoaded(
      herbals: herbals ?? this.herbals,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [herbals, hasReachedMax, isLoadingMore];
}

class HerbalDetailLoaded extends HerbalState {
  final HerbalModel herbal;

  const HerbalDetailLoaded(this.herbal);

  @override
  List<Object> get props => [herbal];
}

class HerbalError extends HerbalState {
  final String message;

  const HerbalError(this.message);

  @override
  List<Object> get props => [message];
} 