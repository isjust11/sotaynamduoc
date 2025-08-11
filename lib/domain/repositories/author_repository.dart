import 'package:sotaynamduoc/domain/data/models/models.dart';

abstract class AuthorRepository {
  Future<List<AuthorModel>> getAuthors();
  Future<AuthorModel> getAuthorById(String id);
  Future<AuthorModel> getAuthorBySlug(String slug);
  Future<List<AuthorModel>> searchAuthors(String query);
  Future<List<AuthorModel>> getFamousAuthors();
  Future<List<AuthorModel>> getAuthorsByEra(String era);
  Future<List<AuthorModel>> getAuthorsByDynasty(String dynasty);
  Future<List<AuthorModel>> getAuthorsBySpecialty(String specialty);
}

class AuthorRepositoryImpl implements AuthorRepository {
  @override
  Future<List<AuthorModel>> getAuthors() async {
    // TODO: Implement API call
    return [];
  }

  @override
  Future<AuthorModel> getAuthorById(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<AuthorModel> getAuthorBySlug(String slug) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<List<AuthorModel>> searchAuthors(String query) async {
    // TODO: Implement API call
    return [];
  }

  @override
  Future<List<AuthorModel>> getFamousAuthors() async {
    // TODO: Implement API call
    return [];
  }

  @override
  Future<List<AuthorModel>> getAuthorsByEra(String era) async {
    // TODO: Implement API call
    return [];
  }

  @override
  Future<List<AuthorModel>> getAuthorsByDynasty(String dynasty) async {
    // TODO: Implement API call
    return [];
  }

  @override
  Future<List<AuthorModel>> getAuthorsBySpecialty(String specialty) async {
    // TODO: Implement API call
    return [];
  }
} 