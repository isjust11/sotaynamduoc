import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  // Cấu hình API URL cho các môi trường khác nhau
  static final apiHost = _getApiHost();
  static final storageHost = _getStorageHost();

  static String _getApiHost() {
    // Kiểm tra file .env trước
    final envUrl = dotenv.env['API_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }

    // Fallback cho các môi trường khác nhau
    // LDPlayer/Android Emulator: sử dụng 10.0.2.2 để kết nối với host machine
    return 'http://10.0.2.2:4000';
  }

  static String _getStorageHost() {
    // Kiểm tra file .env trước
    final envUrl = dotenv.env['STORAGE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) {
      return envUrl;
    }

    // Fallback cho storage server
    // LDPlayer/Android Emulator: sử dụng 10.0.2.2 để kết nối với host machine
    return 'http://10.0.2.2:3005';
  }

  static final login = "$apiHost/auth/login";
  static final register = "$apiHost/auth/register";
  static final getUserInfo = "$apiHost/auth/profile";
  // User interaction (new endpoints)
  static final userInteractionsBase = "$apiHost/user-interactions";
  static String likeUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/like/$targetType/$targetId";
  static String unlikeUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/unlike/$targetType/$targetId";
  static String viewUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/view/$targetType/$targetId";
  static String bookmarkUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/bookmark/$targetType/$targetId";
  static String unbookmarkUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/unbookmark/$targetType/$targetId";
  static String shareUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/share/$targetType/$targetId";
  static String rateUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/rate/$targetType/$targetId";
  static String followUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/follow/$targetType/$targetId";
  static String unfollowUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/unfollow/$targetType/$targetId";
  static String interactionStatusUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/status/$targetType/$targetId";
  static String interactionStatsUrl(String targetType, dynamic targetId) =>
      "$userInteractionsBase/stats/$targetType/$targetId";
  static String myInteractionsUrl({Map<String, dynamic>? query}) {
    if (query == null || query.isEmpty) {
      return "$userInteractionsBase/my-interactions";
    }
    final qp = query.entries
        .where((e) => e.value != null && e.value.toString().isNotEmpty)
        .map((e) => "${e.key}=${Uri.encodeComponent(e.value.toString())}")
        .join('&');
    return "$userInteractionsBase/my-interactions?$qp";
  }

  static final getCategories = "$apiHost/categories";
  static final getCategoriesByCategoryTypeCode =
      "$apiHost/categories/get-by-category-type";
  static final getFolkMedicines = "$apiHost/folk-medicine";
  static final getHerbals = "$apiHost/herbals";
  static final verifyPin = "$apiHost/auth/verify-pin";
  static final resendPin = "$apiHost/auth/resend-pin";
  static final mobileSocialLogin = "$apiHost/auth/mobile/social-login";
  static final refreshToken = "$apiHost/auth/refresh-token";
  static final getPage = "$apiHost/pages";
  static final createFeedback = "$apiHost/feedback";
  static final updateProfile = "$apiHost/auth/update-profile";
  static final getMedia = "$apiHost/media";
  static final getTips = "$apiHost/article/tips";
  static final registerFcmToken = "$apiHost/fcm-tokens/register";
  static final sendFcmToken = "$apiHost/fcm-tokens/send";
  static final subscribeToTopic = "$apiHost/fcm-tokens/subscribe-topic";
  static final unsubscribeFromTopic = "$apiHost/fcm-tokens/unsubscribe-topic";
  static final sendToTopic = "$apiHost/notifications/fcm/send-topic";
  static final sendToToken = "$apiHost/notifications/fcm/send-token";
}
