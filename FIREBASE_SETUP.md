# Firebase Cloud Messaging Setup Guide

## 1. Tạo Firebase Project

1. Truy cập [Firebase Console](https://console.firebase.google.com/)
2. Tạo project mới hoặc chọn project hiện có
3. Bật Authentication và Cloud Messaging

## 2. Cấu hình Android

1. Thêm Android app vào Firebase project
2. Tải file `google-services.json` và đặt vào `android/app/`
3. Cập nhật `android/app/build.gradle`:

```gradle
dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-messaging'
    implementation 'com.google.firebase:firebase-analytics'
}
```

4. Cập nhật `android/build.gradle`:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

5. Thêm plugin vào `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'
```

## 3. Cấu hình iOS

1. Thêm iOS app vào Firebase project
2. Tải file `GoogleService-Info.plist` và đặt vào `ios/Runner/`
3. Cập nhật `ios/Runner/Info.plist`:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

## 4. Cập nhật Firebase Options

Cập nhật file `lib/firebase_options.dart` với thông tin từ Firebase Console:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'your-android-api-key',
  appId: 'your-android-app-id',
  messagingSenderId: 'your-sender-id',
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
);
```

## 5. Cấu hình Backend

1. Tải service account key từ Firebase Console
2. Đặt file JSON vào `codebase-admin/` folder
3. Cập nhật `FIREBASE_SERVICE_ACCOUNT_KEY` trong `.env`

## 6. Test FCM

1. Chạy app và vào FCM Test Screen
2. Subscribe to topic "test"
3. Gửi test notification từ backend
4. Kiểm tra notification trên device

## 7. Các Topics được sử dụng

- `test`: Test notifications
- `news`: Tin tức mới
- `promotions`: Khuyến mãi
- `updates`: Cập nhật app

## 8. Troubleshooting

### Lỗi thường gặp:

1. **Token không được tạo**: Kiểm tra Firebase configuration
2. **Notification không hiển thị**: Kiểm tra permission và channel setup
3. **Background message không hoạt động**: Kiểm tra `onBackgroundMessage` handler

### Debug:

```dart
// Thêm vào main.dart để debug
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('Got a message whilst in the foreground!');
  print('Message data: ${message.data}');
});
```
