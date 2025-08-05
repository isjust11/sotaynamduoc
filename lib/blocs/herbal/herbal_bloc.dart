import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'herbal_event.dart';
import 'herbal_state.dart';

class HerbalBloc extends Bloc<HerbalEvent, HerbalState> {
  final HerbalRepository repository;
  int _pageNum = 1;
  bool _hasReachedMax = false;
  static const int _pageSize = 12;

  HerbalBloc({required this.repository}) : super(HerbalInitial()) {
    on<GetHerbalsEvent>(_onGetHerbals);
    on<GetHerbalByIdEvent>(_onGetHerbalById);
    on<GetHerbalsByCategoryEvent>(_onGetHerbalsByCategory);
    on<GetHerbalsByScientificNameEvent>(_onGetHerbalsByScientificName);
    on<GetHerbalsByFamilyEvent>(_onGetHerbalsByFamily);
    on<IncrementViewCountEvent>(_onIncrementViewCount);
    on<IncrementLikeCountEvent>(_onIncrementLikeCount);
    on<ClearHerbalStateEvent>(_onClearState);
    on<LoadMoreHerbalsEvent>(_onLoadMoreHerbals);
    on<RefreshHerbalsEvent>(_onRefreshHerbals);
  }

  Future<void> _onGetHerbals(GetHerbalsEvent event, Emitter<HerbalState> emit) async {
    try {
      if (event.isRefresh) {
        _pageNum = 1;
        _hasReachedMax = false;
        emit(HerbalLoading());
      } else if (state is! HerbalLoading) {
        emit(HerbalLoading());
      }

      // if (_hasReachedMax && !event.isRefresh) {
      //   return;
      // }

      List<HerbalModel> herbals = await repository.getHerbals(
        page: _pageNum,
        limit: _pageSize,
        search: event.search,
        categoryId: event.categoryId,
        scientificName: event.scientificName,
        family: event.family,
        isActive: event.isActive,
      );

      // if (herbals.isEmpty) {
      //   _hasReachedMax = true;
      // } else {
      //   _pageNum++;
      // }

      List<HerbalModel> currentHerbals = [];
      if (state is HerbalLoaded && !event.isRefresh) {
        currentHerbals = (state as HerbalLoaded).herbals;
      }

      List<HerbalModel> newHerbals = event.isRefresh ? herbals : [...currentHerbals, ...herbals];
      
      emit(HerbalLoaded(
        herbals: newHerbals,
        hasReachedMax: _hasReachedMax,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onGetHerbalById(GetHerbalByIdEvent event, Emitter<HerbalState> emit) async {
    try {
      emit(HerbalLoading());
      HerbalModel herbal = await repository.getHerbalById(event.id);
      emit(HerbalDetailLoaded(herbal));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onGetHerbalsByCategory(GetHerbalsByCategoryEvent event, Emitter<HerbalState> emit) async {
    try {
      emit(HerbalLoading());
      List<HerbalModel> herbals = await repository.getHerbalsByCategory(event.categoryId);
      emit(HerbalLoaded(herbals: herbals));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onGetHerbalsByScientificName(GetHerbalsByScientificNameEvent event, Emitter<HerbalState> emit) async {
    try {
      emit(HerbalLoading());
      List<HerbalModel> herbals = await repository.getHerbalsByScientificName(event.scientificName);
      emit(HerbalLoaded(herbals: herbals));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onGetHerbalsByFamily(GetHerbalsByFamilyEvent event, Emitter<HerbalState> emit) async {
    try {
      emit(HerbalLoading());
      List<HerbalModel> herbals = await repository.getHerbalsByFamily(event.family);
      emit(HerbalLoaded(herbals: herbals));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onIncrementViewCount(IncrementViewCountEvent event, Emitter<HerbalState> emit) async {
    try {
      await repository.incrementViewCount(event.id);
      
      // Update the herbal in the current state
      if (state is HerbalLoaded) {
        final currentState = state as HerbalLoaded;
        final updatedHerbals = currentState.herbals.map((herbal) {
          if (herbal.id == event.id) {
            return herbal.copyWith(
              viewCount: (herbal.viewCount ?? 0) + 1,
            );
          }
          return herbal;
        }).toList();
        
        emit(HerbalLoaded(
          herbals: updatedHerbals,
          hasReachedMax: currentState.hasReachedMax,
          isLoadingMore: currentState.isLoadingMore,
        ));
      }
    } catch (e) {
      // Silently handle error for view count increment
    }
  }

  Future<void> _onIncrementLikeCount(IncrementLikeCountEvent event, Emitter<HerbalState> emit) async {
    try {
      await repository.incrementLikeCount(event.id);
      
      // Update the herbal in the current state
      if (state is HerbalLoaded) {
        final currentState = state as HerbalLoaded;
        final updatedHerbals = currentState.herbals.map((herbal) {
          if (herbal.id == event.id) {
            return herbal.copyWith(
              likeCount: (herbal.likeCount ?? 0) + 1,
            );
          }
          return herbal;
        }).toList();
        
        emit(HerbalLoaded(
          herbals: updatedHerbals,
          hasReachedMax: currentState.hasReachedMax,
          isLoadingMore: currentState.isLoadingMore,
        ));
      }
    } catch (e) {
      // Silently handle error for like count increment
    }
  }

  void _onClearState(ClearHerbalStateEvent event, Emitter<HerbalState> emit) {
    _pageNum = 1;
    _hasReachedMax = false;
    emit(HerbalInitial());
  }

  Future<void> _onLoadMoreHerbals(LoadMoreHerbalsEvent event, Emitter<HerbalState> emit) async {
    try {
      // Chỉ load more nếu chưa đạt giới hạn và đang ở trạng thái loaded
      if (_hasReachedMax || state is! HerbalLoaded) {
        return;
      }

      final currentState = state as HerbalLoaded;
      
      // Nếu đang loading more thì không làm gì
      if (currentState.isLoadingMore) {
        return;
      }

      // Set loading more state
      emit(currentState.copyWith(isLoadingMore: true));
      
      List<HerbalModel> herbals = await repository.getHerbals(
        page: _pageNum,
        limit: _pageSize,
        isActive: true,
      );

      if (herbals.isEmpty) {
        _hasReachedMax = true;
        emit(currentState.copyWith(
          hasReachedMax: true,
          isLoadingMore: false,
        ));
      } else {
        _pageNum++;
        List<HerbalModel> newHerbals = [...currentState.herbals, ...herbals];
        emit(HerbalLoaded(
          herbals: newHerbals,
          hasReachedMax: _hasReachedMax,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      // Nếu có lỗi, reset loading more state
      if (state is HerbalLoaded) {
        final currentState = state as HerbalLoaded;
        emit(currentState.copyWith(isLoadingMore: false));
      }
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }

  Future<void> _onRefreshHerbals(RefreshHerbalsEvent event, Emitter<HerbalState> emit) async {
    try {
      // Reset pagination
      _pageNum = 1;
      _hasReachedMax = false;
      
      List<HerbalModel> herbals = await repository.getHerbals(
        page: _pageNum,
        limit: _pageSize,
        isActive: true,
      );

      if (herbals.isEmpty) {
        _hasReachedMax = true;
      } else {
        _pageNum++;
      }

      emit(HerbalLoaded(
        herbals: herbals,
        hasReachedMax: _hasReachedMax,
        isLoadingMore: false,
      ));
    } catch (e) {
      emit(HerbalError(BlocUtils.getMessageError(e)));
    }
  }
} 