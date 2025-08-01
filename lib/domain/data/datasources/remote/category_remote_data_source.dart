import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class CategoryRemoteDataSource {
  final Network network;

  CategoryRemoteDataSource({required this.network});

  Future<List<CategoryModel>> getCategories({
    int? page,
    int? limit,
    String? categoryTypeId,
    bool? isActive,
  }) async {
    Map<String, dynamic> params = {};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (categoryTypeId != null) params['categoryTypeId'] = categoryTypeId;
    if (isActive != null) params['isActive'] = isActive;

    ApiResponse apiResponse = await network.get(
      url: ApiConstant.getCategories,
      params: params.isNotEmpty ? params : null,
    );
    
    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data['data'] ?? apiResponse.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.errMessage);
  }

  Future<CategoryModel> getCategoryById(String id) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getCategories}/$id',
    );
    
    if (apiResponse.isSuccess) {
      return CategoryModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.errMessage);
  }

  Future<List<CategoryModel>> getCategoriesByCategoryTypeCode(String categoryTypeCode) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getCategoriesByCategoryTypeCode}/$categoryTypeCode',
    );
    
    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.errMessage);
  }
}
