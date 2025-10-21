import 'package:equatable/equatable.dart';

abstract class KnowledgeEvent extends Equatable {
  const KnowledgeEvent();

  @override
  List<Object> get props => [];
}

class LoadKnowledgeList extends KnowledgeEvent {
  final int page;
  final int size;
  final String? search;
  final String? categoryId;
  final String? articleCode;
  final bool isRefresh;

  const LoadKnowledgeList({
    this.page = 1,
    this.size = 10,
    this.search,
    this.categoryId,
    this.articleCode,
    this.isRefresh = false,
  });

  @override
  List<Object> get props => [
    page,
    size,
    search ?? '',
    categoryId ?? '',
    articleCode ?? '',
    isRefresh,
  ];
}

class LoadKnowledgeDetail extends KnowledgeEvent {
  final String id;

  const LoadKnowledgeDetail(this.id);

  @override
  List<Object> get props => [id];
}

class SearchKnowledge extends KnowledgeEvent {
  final String searchTerm;

  const SearchKnowledge(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}

class RefreshKnowledge extends KnowledgeEvent {
  const RefreshKnowledge();
}

class UpdateKnowledgeView extends KnowledgeEvent {
  final String id;

  const UpdateKnowledgeView(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateKnowledgeLike extends KnowledgeEvent {
  final String id;

  const UpdateKnowledgeLike(this.id);

  @override
  List<Object> get props => [id];
}
