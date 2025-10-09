import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  // Cấu hình API URL cho các môi trường khác nhau
  static final apiHost = _getApiHost();

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

  static final login = "$apiHost/auth/login";
  static final register = "$apiHost/auth/register";
  static final getUserInfo = "$apiHost/auth/profile";
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
}
