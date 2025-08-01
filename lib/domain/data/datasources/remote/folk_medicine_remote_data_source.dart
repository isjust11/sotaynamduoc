import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class FolkMedicineRemoteDataSource {
  final Network network;

  FolkMedicineRemoteDataSource({required this.network});

  Future<List<FolkMedicineModel>> getFolkMedicines({
    int? page,
    int? limit,
    String? categoryId,
    String? search,
  }) async {
    Map<String, dynamic> params = {};
    if (page != null) params['page'] = page;
    if (limit != null) params['limit'] = limit;
    if (categoryId != null) params['categoryId'] = categoryId;
    if (search != null) params['search'] = search;

    ApiResponse apiResponse = await network.get(
      url: ApiConstant.getFolkMedicines,
      params: params.isNotEmpty ? params : null,
    );
    
    if (apiResponse.isSuccess) {
      List<dynamic> data = apiResponse.data['data'] ?? apiResponse.data;
      return data.map((json) => FolkMedicineModel.fromJson(json)).toList();
    }
    return Future.error(apiResponse.errMessage);
  }

  Future<FolkMedicineModel> getFolkMedicineById(String id) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getFolkMedicines}/$id',
    );
    
    if (apiResponse.isSuccess) {
      return FolkMedicineModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.errMessage);
  }

  Future<FolkMedicineModel> getFolkMedicineBySlug(String slug) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getFolkMedicines}/slug/$slug',
    );
    
    if (apiResponse.isSuccess) {
      return FolkMedicineModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.errMessage);
  }
} 