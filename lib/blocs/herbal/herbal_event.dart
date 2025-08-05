import 'package:equatable/equatable.dart';

abstract class HerbalEvent extends Equatable {
  const HerbalEvent();

  @override
  List<Object> get props => [];
}

class GetHerbalsEvent extends HerbalEvent {
  final String? search;
  final String? categoryId;
  final String? scientificName;
  final String? family;
  final bool? isActive;
  final bool isRefresh;

  const GetHerbalsEvent({
    this.search,
    this.categoryId,
    this.scientificName,
    this.family,
    this.isActive,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [
    search ?? '',
    categoryId ?? '',
    scientificName ?? '',
    family ?? '',
    isActive ?? false,
    isRefresh,
  ];
}

class GetHerbalByIdEvent extends HerbalEvent {
  final String id;

  const GetHerbalByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetHerbalsByCategoryEvent extends HerbalEvent {
  final String categoryId;

  const GetHerbalsByCategoryEvent(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class GetHerbalsByScientificNameEvent extends HerbalEvent {
  final String scientificName;

  const GetHerbalsByScientificNameEvent(this.scientificName);

  @override
  List<Object> get props => [scientificName];
}

class GetHerbalsByFamilyEvent extends HerbalEvent {
  final String family;

  const GetHerbalsByFamilyEvent(this.family);

  @override
  List<Object> get props => [family];
}

class IncrementViewCountEvent extends HerbalEvent {
  final String id;

  const IncrementViewCountEvent(this.id);

  @override
  List<Object> get props => [id];
}

class IncrementLikeCountEvent extends HerbalEvent {
  final String id;

  const IncrementLikeCountEvent(this.id);

  @override
  List<Object> get props => [id];
}

class ClearHerbalStateEvent extends HerbalEvent {} 

class LoadMoreHerbalsEvent extends HerbalEvent {}

class RefreshHerbalsEvent extends HerbalEvent {}