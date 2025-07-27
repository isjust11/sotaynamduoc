import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/blocs/news/news_event.dart';
import 'package:sotaynamduoc/blocs/news/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentSearch;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<LoadNewsList>(_onLoadNewsList);
    on<LoadNewsDetail>(_onLoadNewsDetail);
    on<SearchNews>(_onSearchNews);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onLoadNewsList(
    LoadNewsList event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (event.isRefresh) {
        _currentPage = 1;
        _hasMore = true;
        _currentSearch = event.search;
        emit(NewsLoading());
      } else if (event.page == 1) {
        emit(NewsLoading());
      } else if (state is NewsListLoaded) {
        final currentState = state as NewsListLoaded;
        emit(currentState.copyWith(isLoadingMore: true));
      }

      final newsList = await newsRepository.getNewsList(
        page: event.page,
        size: event.size,
        search: event.search,
      );

      if (newsList.isEmpty) {
        if (event.page == 1) {
          emit(const NewsEmpty());
        } else {
          _hasMore = false;
          if (state is NewsListLoaded) {
            final currentState = state as NewsListLoaded;
            emit(currentState.copyWith(hasMore: false, isLoadingMore: false));
          }
        }
        return;
      }

      if (event.page == 1) {
        _currentPage = 1;
        _hasMore = newsList.length >= event.size;
        emit(
          NewsListLoaded(
            newsList: newsList,
            hasMore: _hasMore,
            searchTerm: event.search,
          ),
        );
      } else {
        _currentPage = event.page;
        _hasMore = newsList.length >= event.size;

        if (state is NewsListLoaded) {
          final currentState = state as NewsListLoaded;
          final updatedList = [...currentState.newsList, ...newsList];
          emit(
            currentState.copyWith(
              newsList: updatedList,
              hasMore: _hasMore,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onLoadNewsDetail(
    LoadNewsDetail event,
    Emitter<NewsState> emit,
  ) async {
    try {
      emit(NewsLoading());
      final news = await newsRepository.getNewsDetail(event.id);
      emit(NewsDetailLoaded(news));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    _currentSearch = event.searchTerm;
    add(LoadNewsList(page: 1, search: event.searchTerm, isRefresh: true));
  }

  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsState> emit,
  ) async {
    add(LoadNewsList(page: 1, search: _currentSearch, isRefresh: true));
  }

  void loadMore() {
    if (_hasMore && state is NewsListLoaded) {
      final currentState = state as NewsListLoaded;
      if (!currentState.isLoadingMore) {
        add(LoadNewsList(page: _currentPage + 1, search: _currentSearch));
      }
    }
  }

  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;
}
