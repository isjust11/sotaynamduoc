import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/author_repository.dart';
import 'package:sotaynamduoc/blocs/author/author_event.dart';
import 'package:sotaynamduoc/blocs/author/author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final AuthorRepository repository;
  int _pageNum = 1;
  bool _hasReachedMax = false;
  static const int _pageSize = 12;
  AuthorBloc({required this.repository}) : super(const AuthorInitial()) {
    on<GetAuthorsEvent>(_onGetAuthors);
    on<LoadMoreAuthorsEvent>(_onLoadMoreAuthors);
    on<RefreshAuthorsEvent>(_onRefreshAuthors);
    on<SearchAuthorsEvent>(_onSearchAuthors);
    on<GetAuthorByIdEvent>(_onGetAuthorById);
    on<GetAuthorBySlugEvent>(_onGetAuthorBySlug);
    on<GetFamousAuthorsEvent>(_onGetFamousAuthors);
    on<GetAuthorsByEraEvent>(_onGetAuthorsByEra);
    on<GetAuthorsByDynastyEvent>(_onGetAuthorsByDynasty);
    on<GetAuthorsBySpecialtyEvent>(_onGetAuthorsBySpecialty);
    on<ClearAuthorStateEvent>(_onClearState);
  }

  Future<void> _onGetAuthors(
    GetAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      if (!event.isRefresh) {
        emit(const AuthorLoading());
      }

      final authors = await repository.getAuthors(
        page: _pageNum,
        size: _pageSize,
      );
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onLoadMoreAuthors(
    LoadMoreAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is AuthorLoaded) {
        emit(currentState.copyWith(isLoadingMore: true));

        // Implement pagination logic here
        // For now, just emit the same state
        emit(currentState.copyWith(isLoadingMore: false));
      }
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onRefreshAuthors(
    RefreshAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      final authors = await repository.getAuthors(
        page: _pageNum,
        size: _pageSize,
      );
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onSearchAuthors(
    SearchAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final authors = await repository.searchAuthors(event.query);
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetAuthorById(
    GetAuthorByIdEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final author = await repository.getAuthorById(event.id);
      emit(AuthorDetailLoaded(author));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetAuthorBySlug(
    GetAuthorBySlugEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final author = await repository.getAuthorBySlug(event.slug);
      emit(AuthorDetailLoaded(author));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetFamousAuthors(
    GetFamousAuthorsEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final authors = await repository.getFamousAuthors();
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetAuthorsByEra(
    GetAuthorsByEraEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final authors = await repository.getAuthorsByEra(event.era);
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetAuthorsByDynasty(
    GetAuthorsByDynastyEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final authors = await repository.getAuthorsByDynasty(event.dynasty);
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  Future<void> _onGetAuthorsBySpecialty(
    GetAuthorsBySpecialtyEvent event,
    Emitter<AuthorState> emit,
  ) async {
    try {
      emit(const AuthorLoading());
      final authors = await repository.getAuthorsBySpecialty(event.specialty);
      emit(AuthorLoaded(authors: authors));
    } catch (e) {
      emit(AuthorError(e.toString()));
    }
  }

  void _onClearState(ClearAuthorStateEvent event, Emitter<AuthorState> emit) {
    _pageNum = 1;
    _hasReachedMax = false;
    emit(AuthorInitial());
  }
}
