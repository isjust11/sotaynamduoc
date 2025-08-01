import 'dart:convert';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FolkMedicineLocalDataSource {
  static const String _folkMedicinesKey = "folk_medicines";
  static const String _folkMedicineDetailKey = "folk_medicine_detail_";

  Future<List<FolkMedicineModel>?> getFolkMedicines() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString(_folkMedicinesKey);
      if (data != null) {
        List<dynamic> jsonList = json.decode(data);
        return jsonList.map((json) => FolkMedicineModel.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveFolkMedicines(List<FolkMedicineModel> folkMedicines) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<Map<String, dynamic>> jsonList = folkMedicines.map((medicine) => medicine.toJson()).toList();
      return await prefs.setString(_folkMedicinesKey, json.encode(jsonList));
    } catch (e) {
      return false;
    }
  }

  Future<FolkMedicineModel?> getFolkMedicineById(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString('$_folkMedicineDetailKey$id');
      if (data != null) {
        return FolkMedicineModel.fromJson(json.decode(data));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveFolkMedicineDetail(FolkMedicineModel folkMedicine) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.setString(
        '$_folkMedicineDetailKey${folkMedicine.id}',
        json.encode(folkMedicine.toJson()),
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearFolkMedicines() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_folkMedicinesKey);
    } catch (e) {
      return false;
    }
  }
} 