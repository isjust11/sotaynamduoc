import 'dart:io';

import 'package:sotaynamduoc/domain/network/network.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class MediaRemoteDataSource {
  final Network network;

  MediaRemoteDataSource({required this.network});

  // GET /media - Lấy danh sách media với phân trang
  Future<Map<String, dynamic>> getAllMedia({
    int page = 1,
    int size = 100,
    String? search,
    String? mimeType,
  }) async {
    Map<String, dynamic> params = {'page': page, 'size': size};

    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }

    if (mimeType != null && mimeType.isNotEmpty) {
      params['mimeType'] = mimeType;
    }

    ApiResponse apiResponse = await network.get(
      url: ApiConstant.getMedia,
      params: params,
    );

    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }

    return Future.error(apiResponse.message);
  }

  // GET /media/:id - Lấy chi tiết media theo ID
  Future<MediaModel> getMediaById(String id) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getMedia}/$id',
    );

    if (apiResponse.isSuccess) {
      return MediaModel.fromJson(apiResponse.data);
    }

    return Future.error(apiResponse.message);
  }

  // POST /media/upload - Upload file
  Future<MediaModel> uploadMedia(File file) async {
    ApiResponse apiResponse = await network.upload(
      url: '${ApiConstant.getMedia}/upload',
      file: file,
    );

    if (apiResponse.isSuccess) {
      return MediaModel.fromJson(apiResponse.data);
    }

    return Future.error(apiResponse.message);
  }

  // PUT /media/:id - Cập nhật thông tin media
  Future<MediaModel> updateMedia(
    String id,
    Map<String, dynamic> updateData,
  ) async {
    ApiResponse apiResponse = await network.put(
      url: '${ApiConstant.getMedia}/$id',
      body: updateData,
    );

    if (apiResponse.isSuccess) {
      return MediaModel.fromJson(apiResponse.data);
    }

    return Future.error(apiResponse.message);
  }

  // DELETE /media/:id - Xóa media theo filename
  Future<Map<String, dynamic>> deleteMedia(String filename) async {
    ApiResponse apiResponse = await network.delete(
      url: '${ApiConstant.getMedia}/$filename',
    );

    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }

    return Future.error(apiResponse.message);
  }

  // DELETE /media - Xóa nhiều media
  Future<Map<String, dynamic>> deleteMultipleMedia(
    List<String> filenames,
  ) async {
    ApiResponse apiResponse = await network.delete(
      url: ApiConstant.getMedia,
      body: {'filenames': filenames},
    );

    if (apiResponse.isSuccess) {
      return apiResponse.data;
    }

    return Future.error(apiResponse.message);
  }
}
