import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class HerbalRemoteDataSource {
  final Network network;

  HerbalRemoteDataSource({required this.network});

  Future<List<HerbalModel>> getHerbals({
    int? page,
    int? limit,
    String? search,
    String? categoryId,
    String? scientificName,
    String? family,
    bool? isActive,
  }) async {
    Map<String, dynamic> params = {};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (categoryId != null) params['categoryId'] = categoryId;
    if (scientificName != null) params['scientificName'] = scientificName;
    if (family != null) params['family'] = family;
    if (isActive != null) params['isActive'] = isActive;

    ApiResponse apiResponse = await network.get(
      url: ApiConstant.getHerbals,
      params: params.isNotEmpty ? params : null,
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data['data'] ?? apiResponse.data;
      return data.map((json) => HerbalModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.message);
  }

  Future<HerbalModel> getHerbalById(String id) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getHerbals}/$id',
    );

    if (apiResponse.isSuccess) {
      return HerbalModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  Future<List<HerbalModel>> getHerbalsByCategory(String categoryId) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getHerbals}/category/$categoryId',
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data;
      return data.map((json) => HerbalModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.message);
  }

  Future<List<HerbalModel>> getHerbalsByScientificName(
    String scientificName,
  ) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getHerbals}/scientific-name/$scientificName',
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data;
      return data.map((json) => HerbalModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.message);
  }

  Future<List<HerbalModel>> getHerbalsByFamily(String family) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getHerbals}/family/$family',
    );

    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data;
      return data.map((json) => HerbalModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.message);
  }

  Future<void> incrementViewCount(String id) async {
    ApiResponse apiResponse = await network.post(
      url: '${ApiConstant.getHerbals}/$id/view',
    );

    if (!apiResponse.isSuccess) {
      return Future.error(apiResponse.message);
    }
  }

  Future<void> incrementLikeCount(String id) async {
    ApiResponse apiResponse = await network.post(
      url: '${ApiConstant.getHerbals}/$id/like',
    );

    if (!apiResponse.isSuccess) {
      return Future.error(apiResponse.message);
    }
  }
}
