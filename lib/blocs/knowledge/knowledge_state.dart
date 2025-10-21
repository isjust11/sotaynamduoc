import 'package:equatable/equatable.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';

abstract class KnowledgeState extends Equatable {
  const KnowledgeState();

  @override
  List<Object> get props => [];
}

class KnowledgeInitial extends KnowledgeState {}

class KnowledgeLoading extends KnowledgeState {}

class KnowledgeListLoaded extends KnowledgeState {
  final List<NewsModel> knowledgeList;
  final bool hasMore;
  final bool isLoadingMore;
  final String? searchTerm;

  const KnowledgeListLoaded({
    required this.knowledgeList,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.searchTerm,
  });

  @override
  List<Object> get props => [
    knowledgeList,
    hasMore,
    isLoadingMore,
    searchTerm ?? '',
  ];

  KnowledgeListLoaded copyWith({
    List<NewsModel>? knowledgeList,
    bool? hasMore,
    bool? isLoadingMore,
    String? searchTerm,
  }) {
    return KnowledgeListLoaded(
      knowledgeList: knowledgeList ?? this.knowledgeList,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class KnowledgeDetailLoaded extends KnowledgeState {
  final NewsModel knowledge;

  const KnowledgeDetailLoaded(this.knowledge);

  @override
  List<Object> get props => [knowledge];
}

class KnowledgeError extends KnowledgeState {
  final String message;

  const KnowledgeError(this.message);

  @override
  List<Object> get props => [message];
}

class KnowledgeEmpty extends KnowledgeState {
  final String message;

  const KnowledgeEmpty({this.message = 'Không có kiến thức nào'});

  @override
  List<Object> get props => [message];
}
