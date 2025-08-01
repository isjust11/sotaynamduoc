import 'package:equatable/equatable.dart';

abstract class FolkMedicineEvent extends Equatable {
  const FolkMedicineEvent();

  @override
  List<Object> get props => [];
}

class LoadFolkMedicineList extends FolkMedicineEvent {
  final int page;
  final int size;
  final String? search;
  final String? categoryId;
  final bool isRefresh;

  const LoadFolkMedicineList({
    this.page = 1,
    this.size = 10,
    this.search,
    this.categoryId,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [page, size, search ?? '', categoryId ?? '', isRefresh];
}

class LoadFolkMedicineDetail extends FolkMedicineEvent {
  final String id;

  const LoadFolkMedicineDetail(this.id);

  @override
  List<Object> get props => [id];
}

class LoadFolkMedicineBySlug extends FolkMedicineEvent {
  final String slug;

  const LoadFolkMedicineBySlug(this.slug);

  @override
  List<Object> get props => [slug];
}

class SearchFolkMedicine extends FolkMedicineEvent {
  final String searchTerm;

  const SearchFolkMedicine(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class FilterFolkMedicineByCategory extends FolkMedicineEvent {
  final String categoryId;

  const FilterFolkMedicineByCategory(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

class RefreshFolkMedicine extends FolkMedicineEvent {
  final String? categoryId;
  const RefreshFolkMedicine({this.categoryId});

  @override
  List<Object> get props => [categoryId ?? ''];
} 