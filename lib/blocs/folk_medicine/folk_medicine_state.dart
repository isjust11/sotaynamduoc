import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/folk_medicine_model.dart';

abstract class FolkMedicineState extends Equatable {
  const FolkMedicineState();

  @override
  List<Object> get props => [];
}

class FolkMedicineInitial extends FolkMedicineState {}

class FolkMedicineLoading extends FolkMedicineState {}

class FolkMedicineListLoaded extends FolkMedicineState {
  final List<FolkMedicineModel> folkMedicineList;
  final bool hasMore;
  final bool isLoadingMore;
  final String? searchTerm;
  final String? categoryId;

  const FolkMedicineListLoaded({
    required this.folkMedicineList,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchTerm,
    this.categoryId,
  });

  @override
  List<Object> get props => [
    folkMedicineList,
    hasMore,
    isLoadingMore,
    searchTerm ?? '',
    categoryId ?? '',
  ];

  FolkMedicineListLoaded copyWith({
    List<FolkMedicineModel>? folkMedicineList,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchTerm,
    String? categoryId,
  }) {
    return FolkMedicineListLoaded(
      folkMedicineList: folkMedicineList ?? this.folkMedicineList,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

class FolkMedicineDetailLoaded extends FolkMedicineState {
  final FolkMedicineModel folkMedicine;

  const FolkMedicineDetailLoaded(this.folkMedicine);

  @override
  List<Object> get props => [folkMedicine];
}

class FolkMedicineError extends FolkMedicineState {
  final String message;

  const FolkMedicineError(this.message);

  @override
  List<Object> get props => [message];
}

class FolkMedicineEmpty extends FolkMedicineState {
  final String message;

  const FolkMedicineEmpty({this.message = 'Không có bài thuốc nào'});

  @override
  List<Object> get props => [message];
} 