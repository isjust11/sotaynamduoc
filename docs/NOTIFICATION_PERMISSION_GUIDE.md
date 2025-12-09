# 🔔 Hướng dẫn Notification Permissions

## Vấn đề: Gửi thông báo thành công nhưng không nhận được

### ✅ Các cải tiến đã thực hiện

1. **Thêm kiểm tra permission chi tiết** với emoji logs rõ ràng
2. **Thêm các method mới** để check và request permission
3. **Cập nhật FCM Test Screen** để hiển thị permission status
4. **Thêm logs chi tiết** khi nhận và hiển thị notifications

---

## 🔍 Các trường hợp permission

### iOS - AuthorizationStatus

| Status | Ý nghĩa | Nhận được thông báo? |
|--------|---------|---------------------|
| `authorized` ✅ | User đã cho phép | ✅ Có |
| `provisional` ⚠️ | Cho phép tạm thời (silent) | ⚠️ Silent only |
| `denied` ❌ | User từ chối | ❌ Không |
| `notDetermined` ❓ | Chưa hỏi user | ❌ Không |

### Android

- **Android < 13**: Không cần runtime permission, mặc định được phép
- **Android 13+**: Cần runtime permission `POST_NOTIFICATIONS`
  - User phải chấp nhận khi app yêu cầu
  - Nếu từ chối, phải vào Settings để bật lại

---

## 📋 Các method mới đã thêm

### 1. `isPermissionGranted()`
Kiểm tra xem permission có được cấp không:

```dart
final isGranted = await fcmService.isPermissionGranted();
if (!isGranted) {
  // Show dialog to request permission
}
```

### 2. `getPermissionStatus()`
Lấy thông tin chi tiết về permission:

```dart
final status = await fcmService.getPermissionStatus();
print(status['authorizationStatus']); // "AuthorizationStatus.authorized"
print(status['isGranted']); // true/false
print(status['alert']); // "AppleNotificationSetting.enabled"
```

### 3. `requestPermissionAgain()`
Request permission lại (hữu ích nếu user từ chối lần đầu):

```dart
final granted = await fcmService.requestPermissionAgain();
if (!granted) {
  // Show message: "Please enable in Settings"
}
```

---

## 🧪 Cách test và debug

### Bước 1: Kiểm tra logs khi khởi động app

Tìm các logs sau khi app khởi động:

```
📱 Requesting notification permission...
🔔 Notification permission status: AuthorizationStatus.authorized
✅ User granted notification permission
```

**Nếu thấy:**
- ✅ `User granted notification permission` → OK!
- ❌ `User denied notification permission` → Cần bật trong Settings
- ❓ `Permission not determined yet` → App chưa hỏi permission

### Bước 2: Sử dụng FCM Test Screen

1. Mở app → Navigate đến **FCM Test Screen**
2. Xem card **"Notification Permission"**
3. Kiểm tra status:
   - ✅ **Permission Granted** → OK!
   - ❌ **Permission Denied** → Tap "Request Permission"

![Permission Status Card]
```
┌─────────────────────────────────┐
│ Notification Permission         │
├─────────────────────────────────┤
│ ✅ Permission Granted ✅        │
│                                 │
│ Detailed Status ▼               │
│   authorizationStatus: ...      │
│   isGranted: true               │
│   alert: enabled                │
│   badge: enabled                │
│   sound: enabled                │
└─────────────────────────────────┘
```

### Bước 3: Kiểm tra logs khi gửi notification

Khi gửi notification từ backend, check logs:

```
📩 Received foreground message: <messageId>
   Title: Test Notification
   Body: This is a test
   Data: {}
🔔 Showing local notification...
   Title: Test Notification
   Body: This is a test
✅ Local notification shown successfully
```

**Nếu không thấy logs trên:**
- App không nhận được message từ FCM
- Kiểm tra FCM token có đúng không
- Kiểm tra backend có gửi thành công không

**Nếu thấy logs nhưng không có notification:**
- Check permission status
- Check notification settings trong device settings

---

## 🔧 Troubleshooting

### ❌ Problem: Permission denied

**iOS:**
1. Settings → [Your App] → Notifications
2. Enable "Allow Notifications"
3. Restart app

**Android:**
1. Settings → Apps → [Your App] → Notifications
2. Enable "All [App] notifications"
3. Restart app

### ❌ Problem: Permission granted nhưng vẫn không nhận được

**Kiểm tra:**

1. **FCM Token có đúng không?**
   ```dart
   final token = fcmService.fcmToken;
   print('Token: $token'); // Phải có giá trị
   ```

2. **Backend có gửi đúng token không?**
   - Check logs ở backend
   - Verify token trong database

3. **Message format có đúng không?**
   ```typescript
   // Backend phải gửi có notification payload
   {
     token: "...",
     notification: {  // ← Quan trọng!
       title: "Test",
       body: "Test message"
     },
     data: {}
   }
   ```

4. **Notification channel (Android)**
   - Channel được tạo tự động khi app khởi động
   - Channel ID: `sotaynamduoc_channel`
   - Check trong code: `_initializeLocalNotifications()`

5. **APNS Certificate (iOS)**
   - Firebase Console → Project Settings → Cloud Messaging
   - Upload APNS Authentication Key hoặc Certificate
   - Development vs Production phải khớp với build type

### ❌ Problem: Foreground notification không hiện

**Nguyên nhân:**
- Trong foreground, FCM không tự động hiện notification
- App phải tự show local notification

**Solution:**
- Code đã handle trong `_handleForegroundMessage()`
- Check logs xem có `✅ Local notification shown successfully` không

### ❌ Problem: Background notification không hiện

**Nguyên nhân:**
- Background handler không được đăng ký đúng
- Missing `@pragma('vm:entry-point')`
- iOS thiếu `remote-notification` trong UIBackgroundModes

**Solution:**
- ✅ Đã fix: `@pragma('vm:entry-point')` đã thêm
- ✅ Đã fix: `remote-notification` đã thêm vào Info.plist
- ✅ Đã fix: Background handler được đăng ký trong main.dart

---

## 📱 Platform-specific requirements

### iOS Requirements Checklist

- ✅ APNS Certificate/Key uploaded to Firebase Console
- ✅ Push Notifications capability enabled in Xcode
- ✅ `remote-notification` in UIBackgroundModes (Info.plist)
- ✅ Correct Bundle ID matches Firebase config
- ✅ Test on **real device** (simulator không support push notifications)
- ✅ Correct provisioning profile (dev/prod)

### Android Requirements Checklist

- ✅ `google-services.json` in `android/app/`
- ✅ FCM sender ID matches in firebase_options.dart
- ✅ Notification channel created
- ✅ POST_NOTIFICATIONS permission in AndroidManifest.xml (Android 13+)
- ✅ Internet permission in AndroidManifest.xml

---

## 🎯 Testing checklist

### 1. Permission Request
- [ ] App asks for permission on first launch
- [ ] Permission dialog shows correctly
- [ ] Status is logged correctly

### 2. Foreground Notifications
- [ ] App is in foreground (active)
- [ ] Send notification from backend/Firebase Console
- [ ] Local notification appears
- [ ] Sound/vibration works
- [ ] Logs show: `📩 Received foreground message`

### 3. Background Notifications
- [ ] App is in background (minimized)
- [ ] Send notification
- [ ] System notification appears
- [ ] Logs show: `Received background message` (in background handler)

### 4. Terminated State
- [ ] Kill app completely
- [ ] Send notification
- [ ] System notification appears
- [ ] Tap notification → app opens

### 5. Permission Denied → Re-request
- [ ] Deny permission initially
- [ ] Open FCM Test Screen
- [ ] See "Permission Denied ❌"
- [ ] Tap "Request Permission"
- [ ] Accept permission
- [ ] See "Permission Granted ✅"

---

## 🔬 Debug commands

### Check logs in real-time

**iOS:**
```bash
# Terminal 1: Run app
flutter run -d <ios-device-id>

# Terminal 2: Watch device logs
xcrun simctl spawn booted log stream --predicate 'processImagePath contains "Runner"'
```

**Android:**
```bash
# Terminal 1: Run app
flutter run -d <android-device-id>

# Terminal 2: Watch logcat
adb logcat -s flutter
```

### Test notification from Firebase Console

1. Firebase Console → Cloud Messaging → Send your first message
2. Notification title: `Test`
3. Notification text: `Testing notification`
4. Target: Single device
5. FCM registration token: (paste từ FCM Test Screen)
6. Send test message

---

## 📊 Expected logs flow

### Normal flow (permission granted):

```
1. App starts
📱 Requesting notification permission...
🔔 Notification permission status: AuthorizationStatus.authorized
✅ User granted notification permission
APNS Token ready: <apns_token> (iOS only)
FCM Token: <fcm_token>

2. Notification sent from backend
📩 Received foreground message: <messageId>
   Title: Test Notification
   Body: This is a test
   Data: {}
🔔 Showing local notification...
   Title: Test Notification
   Body: This is a test
✅ Local notification shown successfully
```

### Error flow (permission denied):

```
1. App starts
📱 Requesting notification permission...
🔔 Notification permission status: AuthorizationStatus.denied
❌ User denied notification permission
⚠️ User needs to enable notifications in Settings
FCM Token: <fcm_token>

2. Notification sent from backend
📩 Received foreground message: <messageId>
   Title: Test Notification
   Body: This is a test
   Data: {}
⚠️ Notifications are disabled in app settings
(No notification shown)
```

---

## 💡 Tips

1. **Always check permission first** trước khi gửi notification
2. **Log everything** để dễ debug
3. **Test trên thiết bị thật**, không phải emulator/simulator
4. **Rebuild app** sau khi thay đổi permission settings
5. **Check Firebase Console logs** để xem delivery status
6. **Use FCM Test Screen** để test nhanh trong app

---

## 🔗 Related files

- `lib/services/fcm_service.dart` - Main FCM service với permission handling
- `lib/ui/screen/test/fcm_test_screen.dart` - Test screen với permission status
- `ios/Runner/Info.plist` - iOS config với UIBackgroundModes
- `android/app/src/main/AndroidManifest.xml` - Android permissions

---

*Last updated: December 9, 2025*

