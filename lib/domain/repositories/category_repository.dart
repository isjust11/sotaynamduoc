import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';


class CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepository({
    required this.remoteDataSource,
  });

  Future<List<CategoryModel>> getCategories({
    int? page,
    int? limit,
    String? categoryTypeId,
    bool? isActive,
  }) async {
    try {
      // Try to get from remote first
      final categories = await remoteDataSource.getCategories(
        page: page,
        limit: limit,
        categoryTypeId: categoryTypeId,
        isActive: isActive,
      );
      
      // Save to local cache
      
      return categories;
    } catch (e) {
      // If remote fails, try to get from local cache
      return Future.error(e);
    }
  }

  Future<CategoryModel> getCategoryById(String id) async {
    try {
      return await remoteDataSource.getCategoryById(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<CategoryModel>> getCategoriesByCategoryTypeCode(String categoryTypeCode) async {
    try {
      return await remoteDataSource.getCategoriesByCategoryTypeCode(categoryTypeCode);
    } catch (e) {
      return Future.error(e);
    }
  }
} 