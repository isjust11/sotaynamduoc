import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/folk_medicine_repository.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_event.dart';
import 'package:sotaynamduoc/blocs/folk_medicine/folk_medicine_state.dart';

class FolkMedicineBloc extends Bloc<FolkMedicineEvent, FolkMedicineState> {
  final FolkMedicineRepository folkMedicineRepository;

  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentSearch;
  String? _currentCategoryId;

  FolkMedicineBloc({required this.folkMedicineRepository}) : super(FolkMedicineInitial()) {
    on<LoadFolkMedicineList>(_onLoadFolkMedicineList);
    on<LoadFolkMedicineDetail>(_onLoadFolkMedicineDetail);
    on<LoadFolkMedicineBySlug>(_onLoadFolkMedicineBySlug);
    on<SearchFolkMedicine>(_onSearchFolkMedicine);
    on<FilterFolkMedicineByCategory>(_onFilterFolkMedicineByCategory);
    on<RefreshFolkMedicine>(_onRefreshFolkMedicine);
  }

  Future<void> _onLoadFolkMedicineList(
    LoadFolkMedicineList event,
    Emitter<FolkMedicineState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        _currentPage = 1;
        _hasMore = true;
        _currentSearch = event.search;
        _currentCategoryId = event.categoryId;
        emit(FolkMedicineLoading());
      } else if (event.page == 1) {
        emit(FolkMedicineLoading());
      } else if (state is FolkMedicineListLoaded) {
        final currentState = state as FolkMedicineListLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
      }

      final folkMedicineList = await folkMedicineRepository.getFolkMedicines(
        page: event.page,
        limit: event.size,
        categoryId: event.categoryId,
        search: event.search,
      );

      if (folkMedicineList.isEmpty) {
        if (event.page == 1) {
          emit(const FolkMedicineEmpty());
        } else {
          _hasMore = false;
          if (state is FolkMedicineListLoaded) {
            final currentState = state as FolkMedicineListLoaded;
            emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
          }
        }
        return;
      }

      if (event.page == 1) {
        _currentPage = 1;
        _hasMore = folkMedicineList.length >= event.size;
        emit(
          FolkMedicineListLoaded(
            folkMedicineList: folkMedicineList,
            hasMore: _hasMore,
            searchTerm: event.search,
            categoryId: event.categoryId,
          ),
        );
      } else {
        _currentPage = event.page;
        _hasMore = folkMedicineList.length >= event.size;

        if (state is FolkMedicineListLoaded) {
          final currentState = state as FolkMedicineListLoaded;
          final updatedList = [...currentState.folkMedicineList, ...folkMedicineList];
          emit(
            currentState.copyWith(
              folkMedicineList: updatedList,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(FolkMedicineError(e.toString()));
    }
  }

  Future<void> _onLoadFolkMedicineDetail(
    LoadFolkMedicineDetail event,
    Emitter<FolkMedicineState> emit,
  ) async {
    try {
      emit(FolkMedicineLoading());
      final folkMedicine = await folkMedicineRepository.getFolkMedicineById(event.id);
      emit(FolkMedicineDetailLoaded(folkMedicine));
    } catch (e) {
      emit(FolkMedicineError(e.toString()));
    }
  }

  Future<void> _onLoadFolkMedicineBySlug(
    LoadFolkMedicineBySlug event,
    Emitter<FolkMedicineState> emit,
  ) async {
    try {
      emit(FolkMedicineLoading());
      final folkMedicine = await folkMedicineRepository.getFolkMedicineBySlug(event.slug);
      emit(FolkMedicineDetailLoaded(folkMedicine));
    } catch (e) {
      emit(FolkMedicineError(e.toString()));
    }
  }

  Future<void> _onSearchFolkMedicine(
    SearchFolkMedicine event, 
    Emitter<FolkMedicineState> emit
  ) async {
    _currentSearch = event.searchTerm;
    add(LoadFolkMedicineList(
      page: 1, 
      search: event.searchTerm, 
      categoryId: _currentCategoryId,
      isRefresh: true
    ));
  }

  Future<void> _onFilterFolkMedicineByCategory(
    FilterFolkMedicineByCategory event, 
    Emitter<FolkMedicineState> emit
  ) async {
    _currentCategoryId = event.categoryId;
    add(LoadFolkMedicineList(
      page: 1, 
      search: _currentSearch, 
      categoryId: event.categoryId,
      isRefresh: true
    ));
  }

  Future<void> _onRefreshFolkMedicine(
    RefreshFolkMedicine event,
    Emitter<FolkMedicineState> emit,
  ) async {
    add(LoadFolkMedicineList(
      page: 1, 
      search: _currentSearch, 
      categoryId: _currentCategoryId ?? event.categoryId,
      isRefresh: true
    ));
  }

  void loadMore() {
    if (_hasMore && state is FolkMedicineListLoaded) {
      final currentState = state as FolkMedicineListLoaded;
      if (!currentState.isLoadingMore) {
        add(LoadFolkMedicineList(
          page: _currentPage + 1, 
          search: _currentSearch,
          categoryId: _currentCategoryId,
        ));
      }
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
  String? get currentSearch => _currentSearch;
  String? get currentCategoryId => _currentCategoryId;
} 