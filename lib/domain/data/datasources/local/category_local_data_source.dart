import 'dart:convert';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryLocalDataSource {
  static const String _categoriesKey = "categories";

  Future<List<CategoryModel>?> getCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_categoriesKey);
      if (data != null) {
        List<dynamic> jsonList = json.decode(data);
        return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveCategories(List<CategoryModel> categories) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> jsonList = categories.map((category) => category.toJson()).toList();
      return await prefs.setString(_categoriesKey, json.encode(jsonList));
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCategories() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_categoriesKey);
    } catch (e) {
      return false;
    }
  }
} 