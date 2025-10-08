import 'package:sotaynamduoc/domain/network/network.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';

class PageRemoteDataSource {
  final Network network;

  PageRemoteDataSource({required this.network});

  Future<PageModel> getPageBySlug(String slug) async {
    ApiResponse apiResponse = await network.get(
      url: '${ApiConstant.getPage}/slug/$slug',
    );
    if (apiResponse.isSuccess) {
      return PageModel.fromJson(apiResponse.data);
    }
    return Future.error(apiResponse.message);
  }
}
