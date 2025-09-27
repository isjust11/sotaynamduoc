# Biometric Authentication với Social Login

## Tổng quan

Tính năng này cho phép sử dụng sinh trắc học (biometric authentication) với cả đăng nhập thông thường (username/password) và đăng nhập social (Google/Facebook).

## Cách hoạt động

### 1. Đăng nhập Social
Khi user đăng nhập bằng Google hoặc Facebook:
- Thông tin social login được lưu vào secure storage
- User có thể bật sinh trắc học để đăng nhập lại nhanh chóng

### 2. Đăng nhập Traditional
Khi user đăng nhập bằng username/password:
- Thông tin đăng nhập được lưu vào secure storage
- User có thể bật sinh trắc học để đăng nhập lại nhanh chóng

### 3. Sinh trắc học
- Ưu tiên social login info trước
- Fallback về traditional credentials nếu không có social info
- Hỗ trợ cả hai loại đăng nhập trong cùng một app

## API Methods

### BiometricAuthService

#### Lưu thông tin Social Login
```dart
await BiometricAuthService.storeSocialLoginInfo({
  'platformId': 'google_123456789',
  'email': 'user@example.com',
  'fullName': 'User Name',
  'platform': 'google', // hoặc 'facebook'
  'picture': 'https://example.com/photo.jpg',
  'accessToken': 'google_access_token',
});
```

#### Lấy thông tin Social Login
```dart
final socialInfo = await BiometricAuthService.getStoredSocialLoginInfo();
if (socialInfo != null) {
  print('Platform: ${socialInfo['platform']}');
  print('Email: ${socialInfo['email']}');
}
```

#### Xóa thông tin Social Login
```dart
await BiometricAuthService.clearStoredSocialLoginInfo();
```

#### Xóa tất cả thông tin đăng nhập
```dart
await BiometricAuthService.clearAllStoredLoginInfo();
```

#### Đăng nhập bằng sinh trắc học
```dart
final result = await BiometricAuthService.loginWithBiometrics();
if (result.isSuccess) {
  if (result.isSocialLogin) {
    // Xử lý social login
    final socialData = result.data!;
    // Gọi API social login
  } else {
    // Xử lý traditional login
    final credentials = result.data!;
    // Gọi API traditional login
  }
}
```

### AuthCubit

#### Đăng nhập Google với lưu thông tin
```dart
await authCubit.doGoogleLogin();
// Tự động lưu social login info cho sinh trắc học
```

#### Đăng nhập Facebook với lưu thông tin
```dart
await authCubit.doFacebookLogin();
// Tự động lưu social login info cho sinh trắc học
```

#### Đăng nhập bằng sinh trắc học
```dart
await authCubit.doBiometricLogin();
// Tự động xử lý cả social và traditional login
```

## Cấu trúc dữ liệu

### Social Login Data
```dart
{
  'platformId': String,      // ID từ Google/Facebook
  'email': String,           // Email từ social platform
  'fullName': String,        // Tên đầy đủ
  'platform': String,        // 'google' hoặc 'facebook'
  'picture': String?,        // URL ảnh đại diện
  'accessToken': String,     // Access token từ social platform
}
```

### Traditional Login Data
```dart
{
  'username': String,        // Username
  'password': String,        // Password
}
```

## Bảo mật

- Tất cả dữ liệu được lưu trong Flutter Secure Storage
- Fallback về SharedPreferences nếu Secure Storage không khả dụng
- Dữ liệu được mã hóa và chỉ accessible khi device được unlock
- Tự động xóa dữ liệu khi tắt sinh trắc học

## Testing

Sử dụng `BiometricSocialTest` class để test:

```dart
import 'package:sotaynamduoc/services/biometric_social_test.dart';

// Chạy tất cả tests
await BiometricSocialTest.runAllTests();

// Hoặc test riêng lẻ
await BiometricSocialTest.testSocialLoginStorage();
await BiometricSocialTest.testMixedStorage();
await BiometricSocialTest.testBiometricLoginWithSocial();
```

## Lưu ý

1. **Ưu tiên Social Login**: Nếu có cả social và traditional data, sinh trắc học sẽ ưu tiên social login
2. **Tương thích ngược**: Code cũ vẫn hoạt động bình thường
3. **Error Handling**: Tất cả methods đều có error handling và fallback
4. **Performance**: Sử dụng async/await và không block UI thread

## Troubleshooting

### Lỗi thường gặp

1. **"Chưa có thông tin đăng nhập được lưu"**
   - Kiểm tra xem đã đăng nhập thành công chưa
   - Kiểm tra xem có bật sinh trắc học chưa

2. **"Sinh trắc học không khả dụng"**
   - Kiểm tra thiết bị có hỗ trợ sinh trắc học không
   - Kiểm tra user đã thiết lập sinh trắc học chưa

3. **"Chưa có thông tin đăng nhập để bật sinh trắc học"**
   - Cần đăng nhập trước khi bật sinh trắc học
   - Có thể là social login hoặc traditional login

### Debug

Bật debug mode để xem logs chi tiết:

```dart
// Trong main.dart
void main() {
  // Bật debug mode
  assert(() {
    print('Debug mode enabled');
    return true;
  }());
  
  runApp(MyApp());
}
```
