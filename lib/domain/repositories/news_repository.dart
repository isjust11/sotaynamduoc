import 'package:sotaynamduoc/domain/data/datasources/remote/news_remote_data_source.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepository({required this.remoteDataSource});

  Future<List<NewsModel>> getNewsList({
    int page = 1,
    int size = 10,
    String? search,
    String? categoryId,
    String? articleCode,
  }) async {
    return await remoteDataSource.getNewsList(
      page: page,
      size: size,
      search: search,
      categoryId: categoryId,
      articleCode: articleCode,
    );
  }

  Future<List<NewsModel>> getFeaturedNewsList(int page, int pageSize) async {
    return await remoteDataSource.getFeaturedNewsList(page, pageSize);
  }

  Future<List<NewsModel>> getTrendingNewsList() async {
    return await remoteDataSource.getTrendingNewsList();
  }

  Future<List<NewsModel>> getTrendingList({int page = 1, int size = 10}) async {
    return await remoteDataSource.getTrendingList(page: page, size: size);
  }

  Future<List<NewsModel>> getFavoriteList({int page = 1, int size = 10}) async {
    return await remoteDataSource.getFavoriteList(page: page, size: size);
  }

  Future<List<NewsModel>> getRecentList({int page = 1, int size = 10}) async {
    return await remoteDataSource.getRecentList(page: page, size: size);
  }

  Future<List<NewsModel>> getBookmarkedList({
    int page = 1,
    int size = 10,
  }) async {
    return await remoteDataSource.getBookmarkedList(page: page, size: size);
  }

  Future<List<NewsModel>> getRecommendedNewsList(
    List<String> searchData,
  ) async {
    return await remoteDataSource.getRecommendedNewsList(
      searchData: searchData,
    );
  }

  Future<NewsModel> getNewsDetail(String id) async {
    return await remoteDataSource.getNewsDetail(id);
  }

  Future<void> updateNewsView(String id) async {
    return await remoteDataSource.updateNewsView(id);
  }

  Future<void> updateNewsLike(String id) async {
    return await remoteDataSource.updateNewsLike(id);
  }
}
