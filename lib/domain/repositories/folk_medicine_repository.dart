import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';


class FolkMedicineRepository {
  final FolkMedicineRemoteDataSource remoteDataSource;

  FolkMedicineRepository({
    required this.remoteDataSource,
  });

  Future<List<FolkMedicineModel>> getFolkMedicines({
    int? page,
    int? limit,
    String? categoryId,
    String? search,
  }) async {
    try {
      // Try to get from remote first
      final folkMedicines = await remoteDataSource.getFolkMedicines(
        page: page,
        limit: limit,
        categoryId: categoryId,
        search: search,
      );
      
      // Save to local cache
      
      return folkMedicines;
    } catch (e) {
      // If remote fails, try to get from local cache
      return Future.error(e);
    }
  }

  Future<FolkMedicineModel> getFolkMedicineById(String id) async {
    try {
      final folkMedicine = await remoteDataSource.getFolkMedicineById(id);
      // Save to local cache
      return folkMedicine;
    } catch (e) {
      // If remote fails, try to get from local cache
      return Future.error(e);
    }
  }

  Future<FolkMedicineModel> getFolkMedicineBySlug(String slug) async {
    try {
      return await remoteDataSource.getFolkMedicineBySlug(slug);
    } catch (e) {
      return Future.error(e);
    }
  }
} 