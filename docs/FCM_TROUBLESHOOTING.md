# FCM Troubleshooting - Các vấn đề đã Fix

## 🔴 Các vấn đề nghiêm trọng đã được phát hiện và sửa

### 1. **Bug nghiêm trọng: iOS không thể subscribe topic** ❌➡️✅
**Vấn đề:** 
```dart
// Code cũ ở line 333-338
if (Platform.isIOS) {
  debugPrint('APNS disabled on iOS: skipping topic subscription for "$topic"');
  return; // ❌ Return ngay lập tức!
}
```

**Tác động:** Tất cả các thiết bị iOS không bao giờ subscribe được vào topic, dẫn đến không nhận được thông báo gửi theo topic.

**Đã fix:** Xóa đoạn code return sớm này.

---

### 2. **Background message handler thiếu annotation** ❌➡️✅
**Vấn đề:** 
- Background message handler không có `@pragma('vm:entry-point')`
- Không phải top-level function
- Không xử lý gì cả

**Tác động:** 
- Trong release build, Dart tree-shaking có thể loại bỏ function này
- Background messages không được xử lý đúng

**Đã fix:** 
- Tạo top-level function `firebaseMessagingBackgroundHandler`
- Thêm `@pragma('vm:entry-point')`
- Đăng ký trong `main.dart`

```dart
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Received background message: ${message.messageId}');
  debugPrint('Title: ${message.notification?.title}');
  debugPrint('Body: ${message.notification?.body}');
}

void main() async {
  // ...
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // ...
}
```

---

### 3. **Firebase được khởi tạo 2 lần** ❌➡️✅
**Vấn đề:** 
- `main.dart` khởi tạo Firebase (line 21)
- `FCMService.initialize()` lại khởi tạo Firebase một lần nữa (line 41)

**Tác động:** 
- Có thể gây conflict
- Lãng phí resources
- Có thể gây lỗi không mong muốn

**Đã fix:** Xóa việc khởi tạo Firebase trong `FCMService.initialize()`

---

### 4. **messagingSenderId không khớp** ❌➡️✅
**Vấn đề:** 
```dart
// firebase_options.dart
android: messagingSenderId: '228679159711'  // ❌ Sai
ios: messagingSenderId: '700663881543'      // ✅ Đúng
```

**Tác động:** Android có thể không nhận được thông báo do sender ID không đúng.

**Đã fix:** Cập nhật Android messagingSenderId thành `'700663881543'`

---

### 5. **FCMService instance bị mất** ❌➡️✅
**Vấn đề:** 
```dart
// Code cũ
await FCMService(
  fcmRepository: getIt.getIt.get<FcmRepository>(),
).initialize(); // Instance bị mất ngay sau đó
```

**Tác động:** Không có cách nào để gọi các method của FCMService sau khi app đã khởi động.

**Đã fix:** 
```dart
late FCMService fcmService; // Global instance

void main() async {
  fcmService = FCMService(
    fcmRepository: getIt.getIt.get<FcmRepository>(),
  );
  await fcmService.initialize();
}
```

---

### 6. **iOS Info.plist thiếu remote-notification** ❌➡️✅
**Vấn đề:** 
```xml
<!-- Code cũ -->
<key>UIBackgroundModes</key>
<array>
  <string>processing</string>
  <!-- ❌ Thiếu remote-notification -->
</array>
```

**Tác động:** iOS không thể nhận background notifications.

**Đã fix:** 
```xml
<key>UIBackgroundModes</key>
<array>
  <string>processing</string>
  <string>remote-notification</string>  <!-- ✅ Đã thêm -->
</array>
```

---

## ✅ Checklist để test lại

### Trước khi test:
1. ✅ Clean build:
   ```bash
   cd /Users/username/develops/base_app/sotaynamduoc
   flutter clean
   flutter pub get
   cd ios && pod install && cd ..
   ```

2. ✅ Rebuild app:
   ```bash
   # iOS
   flutter build ios --release
   
   # Android
   flutter build apk --release
   ```

### Test scenarios:

#### 1. Test FCM Token Registration
- [ ] Mở app
- [ ] Check logs xem có FCM token không
- [ ] Kiểm tra token có được gửi lên server không (sau khi login)

#### 2. Test Foreground Notifications
- [ ] App đang mở và active
- [ ] Gửi notification từ backend/Firebase console
- [ ] Notification phải hiện lên

#### 3. Test Background Notifications
- [ ] App đang chạy background (minimize app)
- [ ] Gửi notification
- [ ] Notification phải hiện lên trong notification tray

#### 4. Test Topic Subscription (Quan trọng cho iOS!)
- [ ] Subscribe vào một topic
- [ ] Gửi notification đến topic đó
- [ ] Phải nhận được notification

#### 5. Test App Terminated State
- [ ] Kill app hoàn toàn (swipe away)
- [ ] Gửi notification
- [ ] Notification phải hiện lên
- [ ] Tap notification để mở app

---

## 🔍 Debug logs cần kiểm tra

### iOS:
```
APNS Token ready: <token>
FCM Token: <token>
Subscribed to topic: <topic_name>
```

### Android:
```
FCM Token: <token>
Subscribed to topic: <topic_name>
```

### Logs khi nhận notification:
```
// Foreground
Received foreground message: <messageId>

// Background
Received background message: <messageId>

// Notification tapped
Notification tapped: <messageId>
```

---

## 🧪 Test từ backend

Sử dụng API từ `codebase-admin`:

```typescript
// Test gửi đến token cụ thể
POST /notifications/send-to-token
{
  "token": "<fcm_token>",
  "title": "Test Notification",
  "body": "This is a test",
  "data": {}
}

// Test gửi đến topic
POST /notifications/send-to-topic
{
  "topic": "<topic_name>",
  "title": "Test Topic Notification",
  "body": "This is a topic test",
  "data": {}
}
```

---

## 📱 Platform-specific notes

### iOS:
- **APNS Certificate:** Đảm bảo APNS certificate đã được upload lên Firebase Console
- **Development vs Production:** APNS có 2 môi trường riêng biệt
- **Capabilities:** Xcode > Signing & Capabilities > Push Notifications phải được enable
- **Background Modes:** Remote notifications phải được check

### Android:
- **google-services.json:** Đảm bảo file này có trong `android/app/`
- **Firebase SDK:** Phải dùng đúng version trong pubspec.yaml
- **Notification Channel:** Android 8+ yêu cầu notification channel

---

## 🚨 Common issues và solutions

### Issue: "APNS token not set" trên iOS
**Solution:** 
- Kiểm tra APNS certificate trong Firebase Console
- Đảm bảo app được build với đúng provisioning profile
- Test trên thiết bị thật, không phải simulator

### Issue: Không nhận được notification khi app terminated
**Solution:**
- Kiểm tra `UIBackgroundModes` trong Info.plist (iOS)
- Kiểm tra background service trong AndroidManifest.xml (Android)
- Đảm bảo `@pragma('vm:entry-point')` có trong background handler

### Issue: Topic subscription fails
**Solution:**
- Đảm bảo APNS token đã sẵn sàng trước khi subscribe (iOS)
- Check logs để xem error cụ thể
- Retry logic đã được implement trong code

---

## 📝 Next steps

1. Test kỹ trên cả iOS và Android
2. Test trên cả debug và release builds
3. Monitor FCM logs trong Firebase Console
4. Check token registration trong database
5. Verify topic subscriptions hoạt động đúng

---

## 🔗 Related files modified

- `lib/services/fcm_service.dart`
- `lib/main.dart`
- `lib/firebase_options.dart`
- `ios/Runner/Info.plist`

---

*Generated: December 8, 2025*

