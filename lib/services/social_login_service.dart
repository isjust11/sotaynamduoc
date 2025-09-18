import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sotaynamduoc/config/google_signin_config.dart';

class SocialLoginService {
  static final GoogleSignIn _googleSignIn = GoogleSignInConfig.googleSignIn;

  /// Test Google Sign-In configuration
  static Future<void> testGoogleSignInConfig() async {
    try {
      print('=== Testing Google Sign-In Configuration ===');

      // Test 1: Check if GoogleSignIn instance is created
      print('✅ GoogleSignIn instance created');

      // Test 2: Check scopes
      print('✅ Scopes: ${_googleSignIn.scopes}');

      // Test 3: Check Google Play Services availability
      try {
        final bool isSignedIn = await _googleSignIn.isSignedIn();
        print('✅ Google Play Services available: $isSignedIn');
      } catch (e) {
        print('❌ Google Play Services not available: $e');
        print('   - LDPlayer may not have Google Play Services');
        print('   - Try installing Google Play Services in LDPlayer');
        return;
      }

      // Test 4: Try to get current user (silent)
      try {
        final GoogleSignInAccount? currentUser = await _googleSignIn
            .signInSilently();
        print('✅ Silent sign-in: ${currentUser?.email ?? "No user"}');
      } catch (e) {
        print('⚠️ Silent sign-in failed: $e');
      }

      print('=== Configuration Test Complete ===');
    } catch (e) {
      print('❌ Configuration test failed: $e');
    }
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
      print('=== Google Sign-In Debug ===');
      print('Starting Google Sign In...');

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
      final GoogleSignInAccount?
      googleUser = await _googleSignIn.signIn().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception(
            'Google Sign-In timeout - LDPlayer may not support Google Play Services',
          );
        },
      );

      print('Google Sign-In result: ${googleUser?.email}');

      if (googleUser == null) {
        print('User cancelled Google Sign-In');
        return null; // User cancelled
      }

      print('Getting Google authentication...');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print('Google authentication successful');
      print('Access token: ${googleAuth.accessToken?.substring(0, 20)}...');

      return {
        'platformId': googleUser.id,
        'email': googleUser.email,
        'fullName': googleUser.displayName ?? '',
        'picture': googleUser.photoUrl,
        'platform': 'google',
        'accessToken': googleAuth.accessToken,
      };
    } catch (error) {
      print('=== Google Sign-In Error ===');
      print('Error: $error');
      print('Error type: ${error.runtimeType}');
      print('Error details: ${error.toString()}');

      // Xử lý các loại lỗi cụ thể
      if (error.toString().contains('sign_in_failed')) {
        print('❌ Sign in failed - check configuration');
        print('   - Bundle ID: com.example.sotaynamduoc');
        print('   - Check google-services.json');
        print('   - Check SHA-1 fingerprint in Google Console');
      } else if (error.toString().contains('network_error') ||
          error.toString().contains('SocketException') ||
          error.toString().contains('Network is unreachable')) {
        print('❌ Network error - check internet connection');
        print('   - For LDPlayer: Use 10.0.2.2:4000 as API URL');
        print('   - For real device: Use your computer IP address');
        print('   - Check if backend server is running');
      } else if (error.toString().contains('invalid_client')) {
        print('❌ Invalid client - check google-services.json');
        print(
          '   - CLIENT_ID: 228679159711-k41tgofkrglamkn6khb79ttp772ej4ir.apps.googleusercontent.com',
        );
        print('   - BUNDLE_ID: com.example.sotaynamduoc');
        print('   - SHA-1: da86a90be758b3dceb87f3cd3e210a9dc4d6e502');
      } else if (error.toString().contains('developer_error')) {
        print('❌ Developer error - check Google Cloud Console');
        print('   - Enable Google Sign-In API');
        print('   - Check OAuth 2.0 credentials');
        print('   - Verify package name and SHA-1 fingerprint');
      } else if (error.toString().contains('timeout')) {
        print('❌ Google Sign-In timeout');
        print('   - LDPlayer may not support Google Play Services');
        print('   - Try on real device or different emulator');
        print('   - Check if Google Play Services is installed');
      } else if (error.toString().contains('SERVICE_DISABLED') ||
          error.toString().contains('SERVICE_MISSING') ||
          error.toString().contains('SERVICE_VERSION_UPDATE_REQUIRED')) {
        print('❌ Google Play Services issue');
        print('   - LDPlayer may not have Google Play Services');
        print('   - Install Google Play Services in LDPlayer');
        print('   - Or test on real device');
      }

      rethrow;
    }
  }

  /// Đăng nhập bằng Facebook
  static Future<Map<String, dynamic>?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();

        return {
          'platformId': userData['id'],
          'email': userData['email'] ?? '',
          'fullName': userData['name'] ?? '',
          'picture': userData['picture']?['data']?['url'],
          'platform': 'facebook',
          'accessToken': result.accessToken?.token,
        };
      } else {
        return null; // User cancelled or error
      }
    } catch (error) {
      print('Facebook Sign In Error: $error');
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
