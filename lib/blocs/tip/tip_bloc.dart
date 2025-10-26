import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/tip_repository.dart';
import 'package:sotaynamduoc/blocs/tip/tip_event.dart';
import 'package:sotaynamduoc/blocs/tip/tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  final TipRepository tipRepository;

  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentSearch;
  String? _currentCategory;
  String? _currentDifficulty;
  String? _currentTargetAudience;

  TipBloc({required this.tipRepository}) : super(TipInitial()) {
    on<LoadTipList>(_onLoadTipList);
    on<LoadTipDetail>(_onLoadTipDetail);
    on<SearchTip>(_onSearchTip);
    on<RefreshTip>(_onRefreshTip);
    on<UpdateTipView>(_onUpdateTipView);
    on<UpdateTipLike>(_onUpdateTipLike);
    on<UpdateTipBookmark>(_onUpdateTipBookmark);
  }

  Future<void> _onLoadTipList(LoadTipList event, Emitter<TipState> emit) async {
    try {
      if (event.isRefresh) {
        _currentPage = 1;
        _hasMore = true;
        _currentSearch = event.search;
        _currentCategory = event.categoryId;
        _currentDifficulty = event.difficulty;
        _currentTargetAudience = event.targetAudience;
        emit(TipLoading());
      } else if (event.page == 1) {
        emit(TipLoading());
      } else if (state is TipListLoaded) {
        final currentState = state as TipListLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
      }

      final tipList = await tipRepository.getTipList(
        page: event.page,
        size: event.size,
        search: event.search,
        category: event.categoryId,
        difficulty: event.difficulty,
        targetAudience: event.targetAudience,
      );

      if (tipList.isEmpty) {
        if (event.page == 1) {
          emit(const TipEmpty());
        } else {
          _hasMore = false;
          if (state is TipListLoaded) {
            final currentState = state as TipListLoaded;
            emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
          }
        }
        return;
      }

      if (event.page == 1) {
        _currentPage = 1;
        _hasMore = tipList.length >= event.size;
        emit(
          TipListLoaded(
            tipList: tipList,
            hasMore: _hasMore,
            searchTerm: event.search,
          ),
        );
      } else {
        _currentPage = event.page;
        _hasMore = tipList.length >= event.size;

        if (state is TipListLoaded) {
          final currentState = state as TipListLoaded;
          final updatedList = [...currentState.tipList, ...tipList];
          emit(
            currentState.copyWith(
              tipList: updatedList,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  Future<void> _onLoadTipDetail(
    LoadTipDetail event,
    Emitter<TipState> emit,
  ) async {
    try {
      emit(TipLoading());
      final tip = await tipRepository.getTipDetail(event.id);
      if (tip != null) {
        emit(TipDetailLoaded(tip: tip));
      } else {
        emit(const TipError('Không tìm thấy tip'));
      }
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  Future<void> _onUpdateTipView(
    UpdateTipView event,
    Emitter<TipState> emit,
  ) async {
    try {
      // Update view count logic here
      // await tipRepository.updateTipView(event.id);
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  Future<void> _onUpdateTipLike(
    UpdateTipLike event,
    Emitter<TipState> emit,
  ) async {
    try {
      // Update like logic here
      // await tipRepository.updateTipLike(event.id);
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  Future<void> _onUpdateTipBookmark(
    UpdateTipBookmark event,
    Emitter<TipState> emit,
  ) async {
    try {
      // Update bookmark logic here
      // await tipRepository.updateTipBookmark(event.id);
    } catch (e) {
      emit(TipError(e.toString()));
    }
  }

  Future<void> _onSearchTip(SearchTip event, Emitter<TipState> emit) async {
    _currentSearch = event.searchTerm;
    add(
      LoadTipList(
        page: 1,
        search: event.searchTerm,
        categoryId: _currentCategory,
        difficulty: _currentDifficulty,
        targetAudience: _currentTargetAudience,
        isRefresh: true,
      ),
    );
  }

  Future<void> _onRefreshTip(RefreshTip event, Emitter<TipState> emit) async {
    add(
      LoadTipList(
        page: 1,
        search: _currentSearch,
        categoryId: _currentCategory,
        difficulty: _currentDifficulty,
        targetAudience: _currentTargetAudience,
        isRefresh: true,
      ),
    );
  }

  void loadMore() {
    if (_hasMore && state is TipListLoaded) {
      final currentState = state as TipListLoaded;
      if (!currentState.isLoadingMore) {
        add(
          LoadTipList(
            page: _currentPage + 1,
            search: _currentSearch,
            categoryId: _currentCategory,
            difficulty: _currentDifficulty,
            targetAudience: _currentTargetAudience,
          ),
        );
      }
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
}
