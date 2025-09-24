import 'package:equatable/equatable.dart';

abstract class AuthorEvent extends Equatable {
  const AuthorEvent();

  @override
  List<Object?> get props => [];
}

class GetAuthorsEvent extends AuthorEvent {
  final bool isRefresh;

  const GetAuthorsEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class LoadMoreAuthorsEvent extends AuthorEvent {
  const LoadMoreAuthorsEvent();
}

class RefreshAuthorsEvent extends AuthorEvent {
  const RefreshAuthorsEvent();
}

class SearchAuthorsEvent extends AuthorEvent {
  final String query;

  const SearchAuthorsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class GetAuthorByIdEvent extends AuthorEvent {
  final String id;

  const GetAuthorByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetAuthorBySlugEvent extends AuthorEvent {
  final String slug;

  const GetAuthorBySlugEvent(this.slug);

  @override
  List<Object?> get props => [slug];
}

class GetFamousAuthorsEvent extends AuthorEvent {
  const GetFamousAuthorsEvent();
}

class GetAuthorsByEraEvent extends AuthorEvent {
  final String era;

  const GetAuthorsByEraEvent(this.era);

  @override
  List<Object?> get props => [era];
}

class GetAuthorsByDynastyEvent extends AuthorEvent {
  final String dynasty;

  const GetAuthorsByDynastyEvent(this.dynasty);

  @override
  List<Object?> get props => [dynasty];
}

class GetAuthorsBySpecialtyEvent extends AuthorEvent {
  final String specialty;

  const GetAuthorsBySpecialtyEvent(this.specialty);

  @override
  List<Object?> get props => [specialty];
}

class ClearAuthorStateEvent extends AuthorEvent {
  const ClearAuthorStateEvent();

  @override
  List<Object?> get props => [];
}
