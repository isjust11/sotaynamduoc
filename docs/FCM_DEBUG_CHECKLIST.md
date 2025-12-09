# 🔍 FCM Debug Checklist - Tìm Nguyên Nhân Không Nhận Được Thông Báo

## 📋 CHECKLIST - Làm theo từng bước

### ✅ Bước 1: Kiểm tra Backend Firebase Credentials

**Check backend logs khi khởi động:**

```bash
cd /Users/username/develops/base_app/codebase-admin
# Xem logs khi backend khởi động
```

**Tìm dòng này:**
- ✅ `[FirebaseService] Firebase Admin initialized for FCM messaging`
- ❌ `[FirebaseService] Firebase credentials are not fully configured. FCM will be disabled.`

**Nếu thấy dòng ❌:**
1. Check file `.env` có đầy đủ:
   ```
   FIREBASE_PROJECT_ID=sotaynamduoc
   FIREBASE_CLIENT_EMAIL=...
   FIREBASE_PRIVATE_KEY=...
   ```
2. Restart backend: `npm run start`

---

### ✅ Bước 2: Kiểm tra FCM Token trên App

**Chạy app và xem logs:**

```bash
cd /Users/username/develops/base_app/sotaynamduoc
flutter run
```

**Tìm các logs sau:**

```
📱 Requesting notification permission...
🔔 Notification permission status: AuthorizationStatus.authorized  # Phải là authorized!
✅ User granted notification permission
APNS Token ready: <token>  # iOS only
FCM Token: <very_long_token>  # Token này rất quan trọng!
```

**❗ Copy FCM Token này** - Bạn sẽ cần nó!

**Nếu thấy:**
- ❌ `User denied notification permission` → Vào Settings enable notifications
- ❌ `FCM Token: null` → Có vấn đề với Firebase init

---

### ✅ Bước 3: Kiểm tra Permission Status trong App

1. **Mở FCM Test Screen**
2. **Xem card "Notification Permission"**
3. **Phải thấy:** ✅ Permission Granted
4. **Nếu thấy:** ❌ Permission Denied → Tap "Request Permission"

---

### ✅ Bước 4: Test Gửi Notification Trực Tiếp

#### Option A: Từ Firebase Console (Recommended để test)

1. Mở Firebase Console: https://console.firebase.google.com
2. Project: `sotaynamduoc`
3. Cloud Messaging → Send test message
4. Enter FCM token (from Step 2)
5. Title: `Test từ Firebase Console`
6. Body: `Xin chào!`
7. Click "Test"

**Kết quả:**
- ✅ Nhận được notification → FCM hoạt động, vấn đề ở backend
- ❌ Không nhận được → Vấn đề ở app/device config

#### Option B: Từ Backend API

**Test bằng curl:**

```bash
# Thay <FCM_TOKEN> bằng token từ Step 2
# Thay <ACCESS_TOKEN> bằng JWT token của bạn

curl -X POST http://127.0.0.1:4000/notifications/fcm/send-token \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <ACCESS_TOKEN>" \
  -d '{
    "token": "<FCM_TOKEN>",
    "title": "Test từ Backend",
    "body": "Đây là test message"
  }'
```

**Kết quả mong đợi:**
```json
{
  "success": true,
  "messageId": "projects/sotaynamduoc/messages/..."
}
```

**Watch logs trên app:**
```
📩 Received foreground message: <messageId>
   Title: Test từ Backend
   Body: Đây là test message
   Data: {}
🔔 Showing local notification...
✅ Local notification shown successfully
```

---

### ✅ Bước 5: Kiểm tra iOS APNS (Nếu dùng iOS)

#### 5.1 Check APNS Token

**App logs phải có:**
```
APNS Token ready: <apns_token>
```

**Nếu không có:**
- App không lấy được APNS token
- Có thể do: provisioning profile sai, simulator (không support)

#### 5.2 Check Firebase Console APNS Certificate

1. Firebase Console → Project Settings
2. Cloud Messaging tab
3. iOS app configuration
4. Xem có APNS Authentication Key hoặc Certificate không

**Nếu không có:**
- Upload APNS Authentication Key (.p8 file) hoặc
- Upload APNS Certificate (.p12 file)

**Quan trọng:** Development vs Production phải match với build type!

---

### ✅ Bước 6: Test Topic Subscription

#### 6.1 Subscribe to Topic

**Trong FCM Test Screen:**
1. Topic Name: `test`
2. Tap "Subscribe"
3. Xem logs:
   ```
   [FcmCubit] Subscribing to topic: test
   Subscribed to topic: test
   ```

**Backend logs:**
```
[FcmService] Subscribed 1 tokens to topic: test
```

#### 6.2 Send to Topic

**Test bằng curl:**

```bash
curl -X POST http://127.0.0.1:4000/notifications/fcm/send-topic \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <ACCESS_TOKEN>" \
  -d '{
    "topic": "test",
    "title": "Test Topic",
    "body": "Test message to topic"
  }'
```

---

### ✅ Bước 7: Kiểm tra Platform-Specific Settings

#### iOS Checklist:

- [ ] Test trên **thiết bị thật**, không phải simulator
- [ ] Xcode → Target → Signing & Capabilities → Push Notifications enabled
- [ ] Info.plist có `<string>remote-notification</string>` trong UIBackgroundModes
- [ ] APNS Certificate uploaded to Firebase Console
- [ ] Bundle ID match với Firebase config: `com.example.sotaynamduoc`
- [ ] App được build với correct provisioning profile

#### Android Checklist:

- [ ] `google-services.json` trong `android/app/`
- [ ] `messagingSenderId` trong `firebase_options.dart` = `700663881543`
- [ ] AndroidManifest.xml có `<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />`
- [ ] Android 13+ phải grant permission trong Settings

---

## 🔬 DEBUG SCENARIOS

### Scenario 1: "Permission granted nhưng không nhận được"

**Nguyên nhân có thể:**
1. FCM token không đúng hoặc expired
2. Backend không gửi thành công
3. iOS: APNS certificate chưa có/sai
4. Message format không đúng

**Debug steps:**
```bash
# 1. Verify token trong database
# Check xem token có được lưu đúng không

# 2. Test từ Firebase Console trực tiếp
# Bỏ qua backend, test trực tiếp từ Firebase

# 3. Check backend logs khi gửi
# Xem có error không

# 4. iOS: Check APNS certificate
```

### Scenario 2: "Foreground nhận được, background không nhận"

**Nguyên nhân:**
- Background handler không hoạt động
- iOS thiếu remote-notification permission

**Solution:**
- ✅ Đã fix: `@pragma('vm:entry-point')` added
- ✅ Đã fix: `remote-notification` added to Info.plist
- Rebuild app: `flutter clean && flutter run --release`

### Scenario 3: "Backend trả success nhưng app không nhận"

**Check:**
1. Backend có return messageId không?
   ```json
   { "success": true, "messageId": "..." }
   ```
2. MessageId có phải null không?
   - Nếu null → Firebase messaging not initialized
   - Check backend logs: `Firebase Admin initialized`

3. FCM token có đúng không?
   - Copy token từ app
   - Paste vào request
   - Ensure không có spaces/newlines

---

## 🧪 QUICK TEST SCRIPT

Tạo file `test_fcm.sh` để test nhanh:

```bash
#!/bin/bash

# Replace these
FCM_TOKEN="<YOUR_FCM_TOKEN>"
ACCESS_TOKEN="<YOUR_JWT_TOKEN>"
API_URL="http://127.0.0.1:4000"

echo "🧪 Testing FCM Notification..."
echo ""

# Test send to token
echo "📤 Sending to token..."
response=$(curl -s -X POST "$API_URL/notifications/fcm/send-token" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -d "{
    \"token\": \"$FCM_TOKEN\",
    \"title\": \"Test $(date +%H:%M:%S)\",
    \"body\": \"Testing notification at $(date)\"
  }")

echo "Response: $response"
echo ""

# Check if successful
if echo "$response" | grep -q "success.*true"; then
    echo "✅ API returned success"
    echo "📱 Check your device for notification"
else
    echo "❌ API failed"
    echo "Check backend logs for errors"
fi
```

**Usage:**
```bash
chmod +x test_fcm.sh
./test_fcm.sh
```

---

## 📊 EXPECTED LOGS - All Platforms

### When notification is sent successfully:

**Backend logs:**
```
[FcmService] Sending to token: <token>
(No error)
```

**App logs (Foreground):**
```
📩 Received foreground message: <messageId>
   Title: Test
   Body: Test message
   Data: {}
🔔 Showing local notification...
   Title: Test
   Body: Test message
✅ Local notification shown successfully
```

**App logs (Background):**
```
Received background message: <messageId>
Title: Test
Body: Test message
```

**Device:**
- 🔔 Notification appears
- 📳 Sound/vibration (if enabled)
- 📱 Badge update (if configured)

---

## ❌ COMMON ERROR MESSAGES

### Error: "FCM messaging not initialized"

**Backend logs:**
```
[FirebaseService] Firebase credentials are not fully configured
[FcmService] FCM messaging not initialized. Skipping sendToToken
```

**Fix:**
- Check `.env` file has all Firebase credentials
- Restart backend

### Error: "apns-token-not-set" (iOS)

**App logs:**
```
Error subscribing to topic: apns-token-not-set
```

**Fix:**
- Wait longer for APNS token (code đã có retry logic)
- Check APNS certificate in Firebase Console
- Test on real device, not simulator

### Error: "Registration token not registered"

**Backend error:**
```
Error: Registration token not registered
```

**Fix:**
- Token expired hoặc không hợp lệ
- Lấy token mới từ app
- Uninstall/reinstall app để get fresh token

---

## 🎯 FINAL CHECKLIST

Trước khi hỏi thêm, check tất cả:

- [ ] Backend logs show: `Firebase Admin initialized for FCM messaging`
- [ ] App logs show: `✅ User granted notification permission`
- [ ] App logs show: `FCM Token: <valid_token>` (not null)
- [ ] FCM Test Screen shows: `✅ Permission Granted`
- [ ] Test từ Firebase Console → Nhận được notification
- [ ] iOS: APNS Certificate uploaded to Firebase Console
- [ ] iOS: Test trên real device (not simulator)
- [ ] Android: POST_NOTIFICATIONS permission granted (Android 13+)
- [ ] Backend API returns: `{ success: true, messageId: "..." }`
- [ ] App logs show: `📩 Received foreground message`

**Nếu tất cả đều ✅ mà vẫn không nhận:**
- Chụp màn hình logs
- Check thêm Firebase Console → Cloud Messaging → Delivery logs

---

## 📞 Need Help?

Provide these info:
1. Platform: iOS or Android?
2. Backend logs khi gửi notification
3. App logs khi nhận notification
4. Firebase Console delivery status
5. FCM Test Screen screenshot
6. Test từ Firebase Console có nhận được không?

---

*Last updated: December 9, 2025 - 22:30*

