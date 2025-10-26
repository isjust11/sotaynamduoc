import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class TipDataSource {
  final Network _network;

  TipDataSource({required Network network}) : _network = network;

  Future<List<TipModel>> getTipList({
    int page = 1,
    int size = 10,
    String? search,
    String? category,
    String? difficulty,
    String? targetAudience,
    String? sortBy,
    String? sortOrder,
  }) async {
    final response = await _network.get(
      url: ApiConstant.getTips,
      params: {
        'page': page,
        'size': size,
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
        if (difficulty != null && difficulty.isNotEmpty)
          'difficulty': difficulty,
        if (targetAudience != null && targetAudience.isNotEmpty)
          'targetAudience': targetAudience,
        if (sortBy != null && sortBy.isNotEmpty) 'sortBy': sortBy,
        if (sortOrder != null && sortOrder.isNotEmpty) 'sortOrder': sortOrder,
      },
    );
    return response.data.map((json) => TipModel.fromJson(json)).toList();
  }

  Future<TipModel?> getTipDetail(String tipId) async {
    final response = await _network.get(url: '${ApiConstant.getTips}/$tipId');

    if (response.isSuccess) {
      return TipModel.fromJson(response.data);
    }
    return Future.error(response.message);
  }

  Future<List<CategoryModel>> getTipCategories() async {
    final response = await _network.get(
      url: '${ApiConstant.getTips}/categories',
    );
    if (response.isSuccess) {
      return response.data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    return Future.error(response.message);
  }

  Future<List<TipModel>> getRelatedTips(String tipId, {int limit = 5}) async {
    final response = await _network.get(
      url: '${ApiConstant.getTips}/$tipId/related',
      params: {'limit': limit},
    );
    if (response.isSuccess) {
      return response.data.map((json) => TipModel.fromJson(json)).toList();
    }
    return Future.error(response.message);
  }

  Future<List<TipModel>> getPopularTips({int limit = 10}) async {
    final response = await _network.get(
      url: '${ApiConstant.getTips}/popular',
      params: {'limit': limit},
    );
    if (response.isSuccess) {
      return response.data.map((json) => TipModel.fromJson(json)).toList();
    }
    return Future.error(response.message);
  }

  Future<List<TipModel>> getRecentTips({int limit = 10}) async {
    final response = await _network.get(
      url: '${ApiConstant.getTips}/recent',
      params: {'limit': limit},
    );
    if (response.isSuccess) {
      return response.data.map((json) => TipModel.fromJson(json)).toList();
    }
    return Future.error(response.message);
  }
}
