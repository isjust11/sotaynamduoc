import 'package:flutter/foundation.dart';
import 'package:sotaynamduoc/services/biometric_auth_service.dart';

/// Helper class để test secure storage và biometric functionality
/// Chỉ hoạt động trong debug mode
class BiometricTestHelper {
  /// Chạy tất cả các test để kiểm tra secure storage
  static Future<void> runAllTests() async {
    if (!kDebugMode) {
      print('BiometricTestHelper: Only available in debug mode');
      return;
    }

    print('\n=== BIOMETRIC TEST HELPER ===');

    try {
      await _testBiometricCapability();
      await _testSecureStorage();
      await _testBiometricSettings();
      print('\n=== ALL TESTS COMPLETED ===\n');
    } catch (e) {
      print('Test failed with error: $e');
    }
  }

  /// Test khả năng sinh trắc học
  static Future<void> _testBiometricCapability() async {
    print('\n--- Testing Biometric Capability ---');

    final isSupported = await BiometricAuthService.isBiometricSupported();
    print('📱 Device supports biometrics: $isSupported');

    final isEnrolled = await BiometricAuthService.isBiometricEnrolled();
    print('👆 Biometrics enrolled: $isEnrolled');

    final availableBiometrics =
        await BiometricAuthService.getAvailableBiometrics();
    print('🔐 Available biometrics: $availableBiometrics');

    final capability = await BiometricAuthService.checkBiometricCapability();
    print('✅ Overall capability: $capability');
  }

  /// Test secure storage functionality
  static Future<void> _testSecureStorage() async {
    print('\n--- Testing Secure Storage ---');

    const testUsername = 'test_user_123';
    const testPassword = 'test_password_456';

    // Test 1: Lưu thông tin
    print('💾 Storing test credentials...');
    await BiometricAuthService.storeCredentials(testUsername, testPassword);
    print('✅ Credentials stored successfully');

    // Test 2: Đọc thông tin
    print('📖 Reading stored credentials...');
    final credentials = await BiometricAuthService.getStoredCredentials();

    if (credentials != null) {
      print('✅ Credentials retrieved successfully');
      print('   Username: ${credentials['username']}');
      print(
        '   Password: ${credentials['password']?.replaceAll(RegExp(r'.'), '*')}',
      );

      // Kiểm tra tính chính xác
      if (credentials['username'] == testUsername &&
          credentials['password'] == testPassword) {
        print('✅ Credentials match original data');
      } else {
        print('❌ Credentials do not match original data');
      }
    } else {
      print('❌ Failed to retrieve credentials');
    }

    // Test 3: Xóa thông tin
    print('🗑️ Clearing stored credentials...');
    await BiometricAuthService.clearStoredCredentials();

    final clearedCredentials =
        await BiometricAuthService.getStoredCredentials();
    if (clearedCredentials == null) {
      print('✅ Credentials cleared successfully');
    } else {
      print('❌ Failed to clear credentials');
    }
  }

  /// Test biometric settings
  static Future<void> _testBiometricSettings() async {
    print('\n--- Testing Biometric Settings ---');

    // Test 1: Kiểm tra trạng thái ban đầu
    final initialState = await BiometricAuthService.isBiometricEnabledInApp();
    print('🔧 Initial biometric state: $initialState');

    // Test 2: Bật biometric
    print('🔛 Enabling biometric...');
    await BiometricAuthService.setBiometricEnabledInApp(true);

    final enabledState = await BiometricAuthService.isBiometricEnabledInApp();
    print('✅ Biometric enabled state: $enabledState');

    // Test 3: Tắt biometric
    print('🔛 Disabling biometric...');
    await BiometricAuthService.setBiometricEnabledInApp(false);

    final disabledState = await BiometricAuthService.isBiometricEnabledInApp();
    print('✅ Biometric disabled state: $disabledState');

    // Khôi phục trạng thái ban đầu
    await BiometricAuthService.setBiometricEnabledInApp(initialState);
    print('🔄 Restored to initial state: $initialState');
  }

  /// Test authentication (chỉ test khả năng, không thực hiện auth thật)
  static Future<void> testAuthentication() async {
    if (!kDebugMode) return;

    print('\n--- Testing Authentication Flow ---');

    final capability = await BiometricAuthService.checkBiometricCapability();
    if (capability != BiometricCapability.available) {
      print('❌ Biometric not available for testing: $capability');
      return;
    }

    print('⚠️  Note: This would normally trigger biometric authentication');
    print('   Skipping actual authentication in test mode');

    // Trong thực tế, bạn có thể bỏ comment dòng dưới để test authentication thật
    // final result = await BiometricAuthService.authenticateWithBiometrics(
    //   localizedReason: 'Test authentication',
    // );
    // print('🔐 Authentication result: ${result.isSuccess}');
  }

  /// Hiển thị thông tin debug về secure storage
  static Future<void> debugSecureStorageInfo() async {
    if (!kDebugMode) return;

    print('\n--- Secure Storage Debug Info ---');
    print('🔒 Using Flutter Secure Storage with:');
    print('   - Android: Encrypted SharedPreferences');
    print('   - iOS: Keychain (first_unlock_this_device)');
    print('   - Reset on error: true');
    print('   - Synchronizable: false (iOS)');
  }
}
