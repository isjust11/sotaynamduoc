import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class NewsRemoteDataSource {
  final Network network;

  NewsRemoteDataSource({required this.network});

  Future<List<NewsModel>> getNewsList({
    int page = 1,
    int size = 10,
    String? search,
  }) async {
    Map<String, dynamic> params = {'page': page, 'size': size};

    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }

    ApiResponse apiResponse = await network.get(
      url: '/article',
      params: params,
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data['data'] ?? apiResponse.data;
      return data.map((json) => NewsModel.fromJson(json)).toList();
    }

    return Future.error(apiResponse.errMessage);
  }

  Future<NewsModel> getNewsDetail(String id) async {
    ApiResponse apiResponse = await network.get(url: '/article/$id');

    if (apiResponse.isSuccess) {
      return NewsModel.fromJson(apiResponse.data);
    }

    return Future.error(apiResponse.errMessage);
  }
}
