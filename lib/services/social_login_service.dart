import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sotaynamduoc/config/google_signin_config.dart';
import 'dart:io';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';

class SocialLoginService {
  static final GoogleSignIn _googleSignIn = GoogleSignInConfig.googleSignIn;

  /// Kiểm tra xem app có đang chạy trên simulator không
  static bool get isSimulator {
    return Platform.isIOS &&
        Platform.environment['SIMULATOR_DEVICE_NAME'] != null;
  }

  /// Kiểm tra Google Play Services có sẵn không
  static Future<bool> isGooglePlayServicesAvailable() async {
    try {
      await _googleSignIn.isSignedIn();
      return true;
    } catch (e) {
      print('Google Play Services not available: $e');
      return false;
    }
  }

  /// Đăng nhập bằng Google
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      // Kiểm tra Google Play Services availability
      try {
        final bool isAvailable = await _googleSignIn.isSignedIn();
        print('Google Sign-In isSignedIn: $isAvailable');
      } catch (e) {
        print('⚠️ Google Play Services check failed: $e');
      }

      // Thử sign out trước để clear session
      try {
        await _googleSignIn.signOut();
        print('Signed out successfully');
      } catch (e) {
        print('⚠️ Sign out failed (may be normal): $e');
      }

      // Thử sign in với timeout
      print('Attempting to sign in...');
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .signIn()
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () {
              throw Exception(
                AppLocalizations.current.googlePlayServicesNotAvailable,
              );
            },
          );

      print('Google Sign-In result: ${googleUser?.email}');

      if (googleUser == null) {
        throw Exception(AppLocalizations.current.userCancelledGoogleSignIn);
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      return {
        'platformId': googleUser.id,
        'email': googleUser.email,
        'fullName': googleUser.displayName ?? '',
        'picture': googleUser.photoUrl,
        'platform': 'google',
        'accessToken': googleAuth.accessToken,
      };
    } catch (error) {
      // Xử lý các loại lỗi cụ thể
      if (error.toString().contains('sign_in_failed')) {
        throw Exception(AppLocalizations.current.googleSignInFailed);
      } else if (error.toString().contains('network_error') ||
          error.toString().contains('SocketException') ||
          error.toString().contains('Network is unreachable')) {
        throw Exception(AppLocalizations.current.googleNetworkError);
      } else if (error.toString().contains('invalid_client')) {
        throw Exception(AppLocalizations.current.googleInvalidClient);
      } else if (error.toString().contains('developer_error')) {
        throw Exception(AppLocalizations.current.googleDeveloperError);
      } else if (error.toString().contains('timeout')) {
        throw Exception(AppLocalizations.current.googleTimeout);
      } else if (error.toString().contains('timeout')) {
        throw Exception(AppLocalizations.current.googleTimeout);
      } else if (error.toString().contains('SERVICE_DISABLED') ||
          error.toString().contains('SERVICE_MISSING') ||
          error.toString().contains('SERVICE_VERSION_UPDATE_REQUIRED')) {
        throw Exception(
          AppLocalizations.current.googlePlayServicesNotAvailable,
        );
      } else if (error.toString().contains('developer_error')) {
        throw Exception(AppLocalizations.current.googleDeveloperError);
      }

      rethrow;
    }
  }

  /// Đăng nhập bằng Facebook
  static Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      print('Running on simulator: $isSimulator');

      // Cảnh báo nếu đang chạy trên simulator
      if (isSimulator) {
        print('⚠️ WARNING: Running on iOS Simulator');
      }

      // Kiểm tra cấu hình Facebook trước khi đăng nhập
      final status =
          await AppTrackingTransparency.requestTrackingAuthorization();
      if (status == TrackingStatus.authorized) {
        // Gọi FacebookAuth.instance.login() sau đó

        final LoginResult result = await FacebookAuth.instance.login();

        if (result.status == LoginStatus.success) {
          final userData = await FacebookAuth.instance.getUserData();

          // Debug token chi tiết
          final accessToken = result.accessToken?.token;

          if (accessToken == null) {
            throw Exception(AppLocalizations.current.facebookAccessTokenIsNull);
          }

          return {
            'platformId': userData['id'],
            'email': userData['email'] ?? '',
            'fullName': userData['name'] ?? '',
            'picture': userData['picture']?['data']?['url'],
            'platform': 'facebook',
            'accessToken': accessToken,
          };
        } else {
          throw Exception(AppLocalizations.current.facebookLoginFailed);
        }
      } else {
        throw Exception(AppLocalizations.current.facebookLoginFailed);
      }
    } catch (error) {
      // Xử lý lỗi AX Lookup cụ thể cho iOS Simulator
      if (error.toString().contains('AX Lookup problem') ||
          error.toString().contains('Permission denied portName') ||
          error.toString().contains('com.apple.iphone.axserver')) {
        throw Exception(AppLocalizations.current.facebookLoginFailed);
      } else if (error.toString().contains('network_error') ||
          error.toString().contains('SocketException') ||
          error.toString().contains('Network is unreachable')) {
        throw Exception(AppLocalizations.current.facebookNetworkError);
      } else if (error.toString().contains('invalid_client') ||
          error.toString().contains('FacebookAppID')) {
        throw Exception(AppLocalizations.current.facebookInvalidClient);
      }

      rethrow;
    }
  }

  /// Đăng xuất Google
  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  /// Đăng xuất Facebook
  static Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }

  /// Đăng xuất tất cả social accounts
  static Future<void> signOutAll() async {
    await Future.wait([signOutGoogle(), signOutFacebook()]);
  }
}
