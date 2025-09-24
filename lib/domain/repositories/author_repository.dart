import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';



class AuthorRepository {
  final AuthorRemoteDataSource dataSource;

  AuthorRepository({required this.dataSource});

  Future<List<AuthorModel>> getAuthors({int page = 1, int size = 10}) async {
    try {
      return await dataSource.getAuthors( page: page, size: size);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AuthorModel> getAuthorById(String id) async {
    try {
      return await dataSource.getAuthorById(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<AuthorModel> getAuthorBySlug(String slug) async {
    try {
      return await dataSource.getAuthorBySlug(slug);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<AuthorModel>> searchAuthors(String query) async {
    try {
      return await dataSource.searchAuthors(query);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<AuthorModel>> getFamousAuthors() async {
    try {
      return await dataSource.getFamousAuthors();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<AuthorModel>> getAuthorsByEra(String era) async {
    try {
      return await dataSource.getAuthorsByEra(era);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<AuthorModel>> getAuthorsByDynasty(String dynasty) async {
    try {
      return await dataSource.getAuthorsByDynasty(dynasty);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<AuthorModel>> getAuthorsBySpecialty(String specialty) async {
    try {
      return await dataSource.getAuthorsBySpecialty(specialty);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> incrementViewCount(String id) async {
    try {
      await dataSource.incrementViewCount(id);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> incrementLikeCount(String id) async {
    try {
      await dataSource.incrementLikeCount(id);
    } catch (e) {
      return Future.error(e);
    }
  }
} 