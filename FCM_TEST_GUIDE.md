# 🧪 FCM Test Guide

## 1. Kiểm tra cấu hình Firebase

### Android:
- ✅ `google-services.json` đã có trong `android/app/`
- ✅ Google Services plugin đã được thêm vào `build.gradle.kts`
- ✅ Permissions đã được thêm vào `AndroidManifest.xml`
- ✅ FCM Services đã được cấu hình

### iOS:
- ✅ `GoogleService-Info.plist` đã có trong `ios/Runner/`
- ✅ Background modes đã được thêm vào `Info.plist`
- ✅ Firebase configuration đã có trong `Info.plist`

## 2. Test FCM trên Flutter

### Bước 1: Chạy app
```bash
cd sotaynamduoc
flutter clean
flutter pub get
flutter run
```

### Bước 2: Kiểm tra FCM Token
1. Mở app và vào Settings
2. Kiểm tra console log để xem FCM token
3. Token sẽ có dạng: `fGH...` (rất dài)

### Bước 3: Test Topic Subscription
1. Vào FCM Test Screen (nếu có)
2. Subscribe to topic "test"
3. Kiểm tra console log: "Subscribed to topic: test"

## 3. Test từ Backend

### Bước 1: Khởi động Backend
```bash
cd codebase-admin
npm install
npm run start:dev
```

### Bước 2: Test API Endpoints

#### Test gửi notification đến topic:
```bash
curl -X POST http://localhost:3000/api/fcm/send-to-topic \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "topic": "test",
    "title": "Test Notification",
    "body": "This is a test message from backend",
    "data": {
      "type": "test",
      "timestamp": "1234567890"
    }
  }'
```

#### Test gửi notification đến token cụ thể:
```bash
curl -X POST http://localhost:3000/api/fcm/send-to-token \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{
    "token": "FCM_TOKEN_FROM_APP",
    "title": "Direct Notification",
    "body": "This is a direct message",
    "data": {
      "type": "direct",
      "screen": "profile"
    }
  }'
```

## 4. Test Scenarios

### Scenario 1: Foreground Notification
1. App đang mở và active
2. Gửi notification từ backend
3. Kiểm tra: Notification hiển thị trong app

### Scenario 2: Background Notification
1. App đang chạy nhưng không active (minimized)
2. Gửi notification từ backend
3. Kiểm tra: Notification hiển thị trong notification tray

### Scenario 3: Terminated App
1. App đã bị đóng hoàn toàn
2. Gửi notification từ backend
3. Kiểm tra: Notification hiển thị và tap để mở app

### Scenario 4: Topic Subscription
1. Subscribe to topic "news"
2. Gửi notification đến topic "news"
3. Kiểm tra: Tất cả devices subscribe topic "news" nhận được notification

## 5. Debug FCM

### Kiểm tra logs:
```dart
// Thêm vào main.dart để debug
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  print('=== FCM MESSAGE ===');
  print('Message ID: ${message.messageId}');
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');
  print('==================');
});
```

### Kiểm tra token:
```dart
// Thêm vào FCM Service
FirebaseMessaging.instance.onTokenRefresh.listen((token) {
  print('FCM Token refreshed: $token');
});
```

## 6. Troubleshooting

### Lỗi thường gặp:

1. **"No FCM token"**
   - Kiểm tra Firebase configuration
   - Kiểm tra internet connection
   - Restart app

2. **"Notification not received"**
   - Kiểm tra notification permissions
   - Kiểm tra topic subscription
   - Kiểm tra backend logs

3. **"Background message not handled"**
   - Kiểm tra `onBackgroundMessage` handler
   - Kiểm tra iOS background modes

### Debug commands:
```bash
# Flutter logs
flutter logs

# Android logs
adb logcat | grep -i firebase

# iOS logs (trong Xcode)
# Xcode > Window > Devices and Simulators > View Device Logs
```

## 7. Production Checklist

- [ ] Firebase project đã được cấu hình đúng
- [ ] Service account key đã được cấu hình cho backend
- [ ] App đã được test trên cả Android và iOS
- [ ] Notification permissions đã được request
- [ ] Topic subscription hoạt động
- [ ] Background notifications hoạt động
- [ ] Notification tap navigation hoạt động
