import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class PageRepository {
  final PageRemoteDataSource pageRemoteDataSource;

  PageRepository({required this.pageRemoteDataSource});

  Future<PageModel> getPageBySlug(String slug) async {
    PageModel pageModel;
    try {
      pageModel = await pageRemoteDataSource.getPageBySlug(slug);
    } catch (e) {
      return Future.error(e);
    }
    return pageModel;
  }
}
