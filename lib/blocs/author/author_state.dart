import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

abstract class AuthorState extends Equatable {
  const AuthorState();

  @override
  List<Object?> get props => [];
}

class AuthorInitial extends AuthorState {
  const AuthorInitial();
}

class AuthorLoading extends AuthorState {
  const AuthorLoading();
}

class AuthorLoaded extends AuthorState {
  final List<AuthorModel> authors;
  final bool hasReachedMax;
  final bool isLoadingMore;

  const AuthorLoaded({
    required this.authors,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  AuthorLoaded copyWith({
    List<AuthorModel>? authors,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return AuthorLoaded(
      authors: authors ?? this.authors,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [authors, hasReachedMax, isLoadingMore];
}

class AuthorDetailLoaded extends AuthorState {
  final AuthorModel author;

  const AuthorDetailLoaded(this.author);

  @override
  List<Object?> get props => [author];
}

class AuthorError extends AuthorState {
  final String message;

  const AuthorError(this.message);

  @override
  List<Object?> get props => [message];
} 