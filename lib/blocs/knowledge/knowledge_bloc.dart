import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/blocs/knowledge/knowledge_event.dart';
import 'package:sotaynamduoc/blocs/knowledge/knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
  final NewsRepository newsRepository;

  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentSearch;

  KnowledgeBloc({required this.newsRepository}) : super(KnowledgeInitial()) {
    on<LoadKnowledgeList>(_onLoadKnowledgeList);
    on<LoadKnowledgeDetail>(_onLoadKnowledgeDetail);
    on<SearchKnowledge>(_onSearchKnowledge);
    on<RefreshKnowledge>(_onRefreshKnowledge);
    on<UpdateKnowledgeView>(_onUpdateKnowledgeView);
    on<UpdateKnowledgeLike>(_onUpdateKnowledgeLike);
  }

  Future<void> _onLoadKnowledgeList(
    LoadKnowledgeList event,
    Emitter<KnowledgeState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        _currentPage = 1;
        _hasMore = true;
        _currentSearch = event.search;
        emit(KnowledgeLoading());
      } else if (event.page == 1) {
        emit(KnowledgeLoading());
      } else if (state is KnowledgeListLoaded) {
        final currentState = state as KnowledgeListLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
      }

      final knowledgeList = await newsRepository.getNewsList(
        page: event.page,
        size: event.size,
        search: event.search,
        categoryId: event.categoryId,
        articleCode: event.articleCode,
      );

      if (knowledgeList.isEmpty) {
        if (event.page == 1) {
          emit(const KnowledgeEmpty());
        } else {
          _hasMore = false;
          if (state is KnowledgeListLoaded) {
            final currentState = state as KnowledgeListLoaded;
            emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
          }
        }
        return;
      }

      if (event.page == 1) {
        _currentPage = 1;
        _hasMore = knowledgeList.length >= event.size;
        emit(
          KnowledgeListLoaded(
            knowledgeList: knowledgeList,
            hasMore: _hasMore,
            searchTerm: event.search,
          ),
        );
      } else {
        _currentPage = event.page;
        _hasMore = knowledgeList.length >= event.size;

        if (state is KnowledgeListLoaded) {
          final currentState = state as KnowledgeListLoaded;
          final updatedList = [...currentState.knowledgeList, ...knowledgeList];
          emit(
            currentState.copyWith(
              knowledgeList: updatedList,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(KnowledgeError(e.toString()));
    }
  }

  Future<void> _onLoadKnowledgeDetail(
    LoadKnowledgeDetail event,
    Emitter<KnowledgeState> emit,
  ) async {
    try {
      emit(KnowledgeLoading());
      final knowledge = await newsRepository.getNewsDetail(event.id);
      emit(KnowledgeDetailLoaded(knowledge));
    } catch (e) {
      emit(KnowledgeError(e.toString()));
    }
  }

  Future<void> _onUpdateKnowledgeView(
    UpdateKnowledgeView event,
    Emitter<KnowledgeState> emit,
  ) async {
    try {
      await newsRepository.updateNewsView(event.id);
    } catch (e) {
      emit(KnowledgeError(e.toString()));
    }
  }

  Future<void> _onUpdateKnowledgeLike(
    UpdateKnowledgeLike event,
    Emitter<KnowledgeState> emit,
  ) async {
    try {
      await newsRepository.updateNewsLike(event.id);
    } catch (e) {
      emit(KnowledgeError(e.toString()));
    }
  }

  Future<void> _onSearchKnowledge(
    SearchKnowledge event,
    Emitter<KnowledgeState> emit,
  ) async {
    _currentSearch = event.searchTerm;
    add(LoadKnowledgeList(page: 1, search: event.searchTerm, isRefresh: true));
  }

  Future<void> _onRefreshKnowledge(
    RefreshKnowledge event,
    Emitter<KnowledgeState> emit,
  ) async {
    add(LoadKnowledgeList(page: 1, search: _currentSearch, isRefresh: true));
  }

  void loadMore() {
    if (_hasMore && state is KnowledgeListLoaded) {
      final currentState = state as KnowledgeListLoaded;
      if (!currentState.isLoadingMore) {
        add(LoadKnowledgeList(page: _currentPage + 1, search: _currentSearch));
      }
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
}
