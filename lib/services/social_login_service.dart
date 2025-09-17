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

      // Test 3: Try to get current user (silent)
      try {
        final GoogleSignInAccount? currentUser = await _googleSignIn
            .signInSilently();
        print('✅ Silent sign-in: ${currentUser?.email ?? "No user"}');
      } catch (e) {
        print('⚠️ Silent sign-in failed: $e');
      }

      // Test 4: Check if signed in
      final bool isSignedIn = await _googleSignIn.isSignedIn();
      print('✅ Is signed in: $isSignedIn');

      print('=== Configuration Test Complete ===');
    } catch (e) {
      print('❌ Configuration test failed: $e');
    }
  }

  /// Đăng nhập bằng Google
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      print('=== Google Sign-In Debug ===');
      print('Starting Google Sign In...');

      // Kiểm tra xem Google Sign-In có available không
      final bool isAvailable = await _googleSignIn.isSignedIn();
      print('Google Sign-In isSignedIn: $isAvailable');

      // Kiểm tra current user
      final GoogleSignInAccount? currentUser = await _googleSignIn
          .signInSilently();
      print('Current user (silent): ${currentUser?.email}');

      // Thử sign out trước để clear session
      await _googleSignIn.signOut();
      print('Signed out successfully');

      // Thử sign in
      print('Attempting to sign in...');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
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

      if (error.toString().contains('sign_in_failed')) {
        print('❌ Sign in failed - check configuration');
        print('   - Bundle ID: com.example.sotaynamduoc');
        print('   - Check GoogleService-Info.plist');
        print('   - Check Info.plist URL scheme');
      } else if (error.toString().contains('network_error')) {
        print('❌ Network error - check internet connection');
      } else if (error.toString().contains('invalid_client')) {
        print('❌ Invalid client - check GoogleService-Info.plist');
        print(
          '   - CLIENT_ID: 700663881543-1mk7ocal2m70mgielnjarbhmu9deoddb.apps.googleusercontent.com',
        );
        print('   - BUNDLE_ID: com.example.sotaynamduoc');
      } else if (error.toString().contains('developer_error')) {
        print('❌ Developer error - check Google Cloud Console');
        print('   - Enable Google Sign-In API');
        print('   - Check OAuth 2.0 credentials');
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
