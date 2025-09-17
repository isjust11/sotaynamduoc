import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInConfig {
  // Cấu hình Google Sign-In
  // Thay đổi clientId này bằng client ID thực từ Google Cloud Console

  // Web Client ID (dùng cho server-side verification)
  static const String webClientId =
      '253093025841-nu14eg05sj43et9bm0njsj9igbl58n46.apps.googleusercontent.com';

  // iOS Client ID (dùng cho iOS app)
  static const String iosClientId =
      '700663881543-1mk7ocal2m70mgielnjarbhmu9deoddb.apps.googleusercontent.com';

  // Android Client ID (dùng cho Android app)
  static const String androidClientId =
      '253093025841-nu14eg05sj43et9bm0njsj9igbl58n46.apps.googleusercontent.com';

  // Cấu hình GoogleSignIn instance
  static GoogleSignIn get googleSignIn => GoogleSignIn(
    scopes: ['email', 'profile'],
    // iOS: Client ID sẽ được đọc từ GoogleService-Info.plist
    // Android: Client ID sẽ được đọc từ google-services.json
    // Web: Có thể dùng webClientId nếu cần
  );

  // Hướng dẫn cấu hình:
  // 1. Tạo project trên Google Cloud Console
  // 2. Enable Google Sign-In API
  // 3. Tạo OAuth 2.0 credentials:
  //    - Android: Thêm package name và SHA-1 fingerprint
  //    - iOS: Thêm bundle identifier
  // 4. Download google-services.json cho Android
  // 5. Download GoogleService-Info.plist cho iOS
  // 6. Thêm các file này vào project Flutter
}
