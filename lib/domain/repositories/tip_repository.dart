import 'package:flutter/foundation.dart';
import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/category_model.dart';
import 'package:sotaynamduoc/domain/data/models/tip_model.dart';

class TipRepository {
  final TipDataSource _dataSource;

  TipRepository({required TipDataSource dataSource}) : _dataSource = dataSource;

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
    return await _dataSource.getTipList(
      page: page,
      size: size,
      search: search,
      category: category,
      difficulty: difficulty,
      targetAudience: targetAudience,
    );
  }

  Future<TipModel?> getTipDetail(String tipId) async {
    return await _dataSource.getTipDetail(tipId);
  }

  Future<List<CategoryModel>> getTipCategories() async {
    return await _dataSource.getTipCategories();
  }

  Future<List<TipModel>> getRelatedTips(String tipId, {int limit = 5}) async {
    return await _dataSource.getRelatedTips(tipId, limit: limit);
  }

  Future<List<TipModel>> getPopularTips({int limit = 10}) async {
    return await _dataSource.getPopularTips(limit: limit);
  }

  Future<List<TipModel>> getRecentTips({int limit = 10}) async {
    return await _dataSource.getRecentTips(limit: limit);
  }
}
