# Hướng dẫn Validation cho Form Đăng nhập

## Tổng quan
Đã thêm validation cho các trường username và password trong màn hình đăng nhập (`signin_screen.dart`).

## Các quy tắc validation

### Username (Tên đăng nhập)
- **Bắt buộc**: Không được để trống
- **Độ dài tối thiểu**: 3 ký tự
- **Độ dài tối đa**: 50 ký tự
- **Ký tự cho phép**: Chỉ chữ cái (a-z, A-Z), số (0-9), dấu chấm (.), gạch dưới (_), gạch ngang (-)

### Password (Mật khẩu)
- **Bắt buộc**: Không được để trống
- **Độ dài tối thiểu**: 6 ký tự
- **Độ dài tối đa**: 100 ký tự

## Cách hoạt động

### 1. Validation tự động
- Validation được kiểm tra khi người dùng nhập liệu (onChanged)
- Thông báo lỗi hiển thị ngay dưới trường input
- Màu đỏ cho thông báo lỗi

### 2. Validation khi submit
- Khi nhấn nút "Đăng nhập", hệ thống kiểm tra validation của tất cả trường
- Chỉ cho phép đăng nhập khi tất cả trường đều hợp lệ
- Hiển thị thông báo lỗi tổng quát nếu có trường không hợp lệ

## Cấu trúc code

### Hàm validation
```dart
// Validation cho username
String? _validateUsername(String value) {
  if (value.isEmpty) {
    return 'Vui lòng nhập tên đăng nhập';
  }
  if (value.length < 3) {
    return 'Tên đăng nhập phải có ít nhất 3 ký tự';
  }
  // ... các quy tắc khác
  return null; // Hợp lệ
}

// Validation cho password
String? _validatePassword(String value) {
  if (value.isEmpty) {
    return 'Vui lòng nhập mật khẩu';
  }
  if (value.length < 6) {
    return 'Mật khẩu phải có ít nhất 6 ký tự';
  }
  // ... các quy tắc khác
  return null; // Hợp lệ
}
```

### Sử dụng trong CustomTextInput
```dart
CustomTextInput(
  key: _usernameFieldKey,
  textController: _usernameController,
  validator: _validateUsername,
  isRequired: true,
  // ... các thuộc tính khác
)
```

### Kiểm tra validation khi submit
```dart
onPressed: () async {
  bool isUsernameValid = _usernameFieldKey.currentState?.isValid ?? false;
  bool isPasswordValid = _passwordFieldKey.currentState?.isValid ?? false;
  
  if (isUsernameValid && isPasswordValid) {
    // Thực hiện đăng nhập
  } else {
    // Hiển thị thông báo lỗi
  }
}
```

## Tùy chỉnh validation

### Thêm quy tắc mới cho username
```dart
String? _validateUsername(String value) {
  // Quy tắc hiện tại...
  
  // Thêm quy tắc mới
  if (value.startsWith('admin')) {
    return 'Tên đăng nhập không được bắt đầu bằng "admin"';
  }
  
  return null;
}
```

### Thêm quy tắc mới cho password
```dart
String? _validatePassword(String value) {
  // Quy tắc hiện tại...
  
  // Thêm quy tắc mới
  if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
    return 'Mật khẩu phải chứa ít nhất 1 chữ thường, 1 chữ hoa và 1 số';
  }
  
  return null;
}
```

## Lưu ý
- Validation hoạt động với widget `CustomTextInput` có sẵn
- Sử dụng `GlobalKey<TextFieldState>` để truy cập trạng thái validation
- Thông báo lỗi hiển thị bằng tiếng Việt
- Có thể dễ dàng mở rộng thêm các quy tắc validation khác
