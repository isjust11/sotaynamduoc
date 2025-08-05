import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class HerbalRepository {
  final HerbalRemoteDataSource remoteDataSource;

  HerbalRepository({
    required this.remoteDataSource,
  });

  Future<List<HerbalModel>> getHerbals({
    int? page,
    int? limit,
    String? search,
    String? categoryId,
    String? scientificName,
    String? family,
    bool? isActive,
  }) async {
    try {
      final herbals = await remoteDataSource.getHerbals(
        page: page,
        limit: limit,
        search: search,
        categoryId: categoryId,
        scientificName: scientificName,
        family: family,
        isActive: isActive,
      );
      
      return herbals;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<HerbalModel> getHerbalById(String id) async {
    try {
      return await remoteDataSource.getHerbalById(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<HerbalModel>> getHerbalsByCategory(String categoryId) async {
    try {
      return await remoteDataSource.getHerbalsByCategory(categoryId);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<HerbalModel>> getHerbalsByScientificName(String scientificName) async {
    try {
      return await remoteDataSource.getHerbalsByScientificName(scientificName);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<HerbalModel>> getHerbalsByFamily(String family) async {
    try {
      return await remoteDataSource.getHerbalsByFamily(family);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> incrementViewCount(String id) async {
    try {
      await remoteDataSource.incrementViewCount(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> incrementLikeCount(String id) async {
    try {
      await remoteDataSource.incrementLikeCount(id);
    } catch (e) {
      return Future.error(e);
    }
  }
} 