import 'package:sotaynamduoc/domain/data/datasources/remote/news_remote_data_source.dart';
import 'package:sotaynamduoc/domain/data/models/news_model.dart';

class NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepository({required this.remoteDataSource});

  Future<List<NewsModel>> getNewsList({
    int page = 1,
    int size = 10,
    String? search,
  }) async {
    return await remoteDataSource.getNewsList(
      page: page,
      size: size,
      search: search,
    );
  }

  Future<NewsModel> getNewsDetail(String id) async {
    return await remoteDataSource.getNewsDetail(id);
  }
}
