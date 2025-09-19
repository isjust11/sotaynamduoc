import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/network/network.dart';

class AuthorRemoteDataSource {
  final Network network;

  AuthorRemoteDataSource({required this.network});

  /// Get all authors with pagination
  Future<List<AuthorModel>> getAuthors({int page = 1, int size = 10}) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors',
      params: {'page': page, 'size': size},
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      } else if (apiResponse.data['data'] is List) {
        return (apiResponse.data['data'] as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Get author by ID
  Future<AuthorModel> getAuthorById(String id) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/$id',
    );
    if (apiResponse.isSuccess) {
      return AuthorModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  /// Get author by slug
  Future<AuthorModel> getAuthorBySlug(String slug) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/slug/$slug',
    );
    if (apiResponse.isSuccess) {
      return AuthorModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }

  /// Search authors by query
  Future<List<AuthorModel>> searchAuthors(String query) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/search/$query',
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Get famous authors
  Future<List<AuthorModel>> getFamousAuthors() async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/famous',
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Get authors by era
  Future<List<AuthorModel>> getAuthorsByEra(String era) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/era/$era',
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Get authors by dynasty
  Future<List<AuthorModel>> getAuthorsByDynasty(String dynasty) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/dynasty/$dynasty',
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Get authors by specialty
  Future<List<AuthorModel>> getAuthorsBySpecialty(String specialty) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.apiHost}/authors/specialty/$specialty',
    );
    if (apiResponse.isSuccess) {
      if (apiResponse.data is List) {
        return (apiResponse.data as List)
            .map((json) => AuthorModel.fromJson(json))
            .toList();
      }
      return [];
    }
    return Future.error(apiResponse.message);
  }

  /// Increment view count for an author
  Future<void> incrementViewCount(String id) async {
    ApiResponse apiResponse = await network.post(
      url: '${ApiConstant.apiHost}/authors/$id/view',
    );
    if (!apiResponse.isSuccess) {
      return Future.error(apiResponse.message);
    }
  }

  /// Increment like count for an author
  Future<void> incrementLikeCount(String id) async {
    ApiResponse apiResponse = await network.post(
      url: '${ApiConstant.apiHost}/authors/$id/like',
    );
    if (!apiResponse.isSuccess) {
      return Future.error(apiResponse.message);
    }
  }
}
