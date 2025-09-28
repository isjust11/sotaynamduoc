# 🔧 APNS Token Debug Guide

## Lỗi: `APNS token has not been set yet`

Lỗi này xảy ra trên iOS khi FCM chưa có APNS token để hoạt động. Đây là cách khắc phục:

## 1. Nguyên nhân

- iOS cần APNS (Apple Push Notification Service) token để FCM hoạt động
- APNS token được tạo bởi iOS system, không phải Firebase
- Có thể mất thời gian để APNS token được tạo

## 2. Giải pháp đã triển khai

### ✅ FCM Service đã được cập nhật:

1. **Auto-retry APNS token**:
   ```dart
   // Tự động retry khi APNS token chưa sẵn sàng
   await _ensureAPNSTokenReady();
   ```

2. **Smart topic subscription**:
   ```dart
   // Kiểm tra APNS token trước khi subscribe
   if (Platform.isIOS) {
     final apnsToken = await _messaging.getAPNSToken();
     // ... retry logic
   }
   ```

3. **Error handling với retry**:
   ```dart
   // Tự động retry khi gặp APNS error
   if (e.toString().contains('apns-token-not-set')) {
     // Retry logic
   }
   ```

## 3. Cách test

### Bước 1: Chạy app trên iOS device/simulator
```bash
flutter run -d ios
```

### Bước 2: Kiểm tra logs
Tìm các log sau trong console:
```
APNS Token ready: <token>
Subscribed to topic: test
```

### Bước 3: Test topic subscription
1. Mở FCM Test Screen
2. Kiểm tra "APNS Token Ready: true"
3. Subscribe to topic "test"
4. Kiểm tra không có lỗi

## 4. Debug Commands

### Kiểm tra APNS token:
```dart
// Trong FCM Test Screen
final apnsReady = await FCMService().isAPNSTokenReady();
print('APNS Ready: $apnsReady');

final apnsToken = await FCMService().getAPNSToken();
print('APNS Token: $apnsToken');
```

### Kiểm tra FCM token:
```dart
final fcmToken = FCMService().fcmToken;
print('FCM Token: $fcmToken');
```

## 5. Troubleshooting

### Nếu vẫn bị lỗi:

1. **Restart app**:
   ```bash
   flutter clean
   flutter run -d ios
   ```

2. **Kiểm tra iOS permissions**:
   - Vào Settings > Notifications
   - Đảm bảo app có permission

3. **Kiểm tra Firebase configuration**:
   - `GoogleService-Info.plist` có đúng không
   - Bundle ID có khớp không

4. **Test trên device thật**:
   - Simulator có thể có vấn đề với APNS
   - Test trên iPhone thật

### Debug logs để tìm:
```
✅ APNS Token ready: <token>
✅ Subscribed to topic: test
❌ APNS token not available, waiting...
❌ Error subscribing to topic test: [firebase_messaging/apns-token-not-set]
```

## 6. Production Checklist

- [ ] Test trên iOS device thật
- [ ] APNS token được tạo thành công
- [ ] Topic subscription hoạt động
- [ ] Notifications được nhận
- [ ] Background notifications hoạt động

## 7. Lưu ý quan trọng

1. **APNS token chỉ có trên iOS** - Android không cần
2. **Cần device thật** - Simulator có thể không hoạt động đúng
3. **Cần internet** - APNS token được tạo qua Apple servers
4. **Cần thời gian** - Có thể mất vài giây để token sẵn sàng

## 8. Code Example

```dart
// Safe topic subscription
Future<void> safeSubscribeToTopic(String topic) async {
  if (Platform.isIOS) {
    // Đợi APNS token sẵn sàng
    bool isReady = false;
    int attempts = 0;
    
    while (!isReady && attempts < 5) {
      isReady = await FCMService().isAPNSTokenReady();
      if (!isReady) {
        await Future.delayed(Duration(seconds: 1));
        attempts++;
      }
    }
  }
  
  // Subscribe topic
  await FCMService().subscribeToTopic(topic);
}
```
