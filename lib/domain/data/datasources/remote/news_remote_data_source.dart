import 'package:sotaynamduoc/domain/data/models/news_model.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class NewsRemoteDataSource {
  final Network network;

  NewsRemoteDataSource({required this.network});

  Future<List<NewsModel>> getNewsList({
    int page = 1,
    int size = 10,
    String? search,
    String? categoryId,
    String? articleCode,
  }) async {
    Map<String, dynamic> params = {'page': page, 'size': size};

    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }

    if (categoryId != null && categoryId.isNotEmpty) {
      params['categoryId'] = categoryId;
    }

    if (articleCode != null && articleCode.isNotEmpty) {
      params['articleCode'] = articleCode;
    }

    ApiResponse apiResponse = await network.get(
      url: '/article',
      params: params,
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data['data'] ?? apiResponse.data;
      return data.map((json) => NewsModel.fromJson(json)).toList();
    }

    return Future.error(apiResponse.message);
  }

  Future<List<NewsModel>> getFeaturedNewsList() async {
    ApiResponse apiResponse = await network.get(url: '/article/featured');

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data ?? apiResponse.data;
      return data.map((json) => NewsModel.fromJson(json)).toList();
    }

    return Future.error(apiResponse.message);
  }

  //get trending new list
  Future<List<NewsModel>> getTrendingNewsList() async {
    ApiResponse apiResponse = await network.get(url: '/article/trending');

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data ?? apiResponse.data;
      return data.map((json) => NewsModel.fromJson(json)).toList();
    }

    return Future.error(apiResponse.message);
  }

  //get recommended new list
  Future<List<NewsModel>> getRecommendedNewsList({
    required List<String> searchData,
  }) async {
    ApiResponse apiResponse = await network.get(
      url: '/article/recommend',
      params: {'searchData': searchData.join(',')},
    );
    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data ?? apiResponse.data;
      return data.map((json) => NewsModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.message);
  }

  Future<NewsModel> getNewsDetail(String id) async {
    ApiResponse apiResponse = await network.get(url: '/article/$id');

    if (apiResponse.isSuccess) {
      return NewsModel.fromJson(apiResponse.data);
    }

    return Future.error(apiResponse.message);
  }

  Future<void> updateNewsView(String id) async {
    ApiResponse apiResponse = await network.post(url: '/article/view/$id');

    if (apiResponse.isSuccess) {
      return;
    }
  }

  Future<void> updateNewsLike(String id) async {
    ApiResponse apiResponse = await network.post(url: '/article/like/$id');

    if (apiResponse.isSuccess) {
      return;
    }
  }
}
