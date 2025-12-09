# 🚀 QUICK DEBUG - 5 Minutes

## Làm ngay 3 bước này để tìm nguyên nhân:

### 📱 BƯỚC 1: Check App Logs (2 phút)

```bash
cd /Users/username/develops/base_app/sotaynamduoc
flutter run
```

**Tìm các dòng này trong logs:**

```
✅ Phải có:
📱 Requesting notification permission...
🔔 Notification permission status: AuthorizationStatus.authorized
✅ User granted notification permission
FCM Token: eA8fX... (token rất dài)

❌ Nếu thấy:
❌ User denied notification permission
→ Vào Settings → Enable notifications

FCM Token: null
→ Firebase init failed
```

### 🔥 BƯỚC 2: Test từ Firebase Console (1 phút)

**Đây là cách NHANH NHẤT để biết vấn đề:**

1. Copy FCM Token từ app logs (dòng `FCM Token: ...`)
2. Mở: https://console.firebase.google.com/project/sotaynamduoc/notification
3. Click "Send your first message" hoặc "New notification"
4. Title: `Test`
5. Body: `Testing`
6. Target: "Send test message"
7. Paste FCM token
8. Click "Test"

**Kết quả:**
- ✅ **Nhận được** → App OK, vấn đề ở backend!
- ❌ **Không nhận** → Vấn đề ở app/device config

### 🖥️ BƯỚC 3: Check Backend (1 phút)

**Backend logs phải có dòng này khi khởi động:**

```bash
cd /Users/username/develops/base_app/codebase-admin
# Xem logs
```

**Phải thấy:**
```
✅ [FirebaseService] Firebase Admin initialized for FCM messaging
```

**Nếu thấy:**
```
❌ [FirebaseService] Firebase credentials are not fully configured
→ Check file .env có đủ: FIREBASE_PROJECT_ID, FIREBASE_CLIENT_EMAIL, FIREBASE_PRIVATE_KEY
```

---

## 🎯 Kết quả sau 3 bước:

### Scenario A: Firebase Console test ✅ nhận được

**→ Vấn đề: Backend không gửi đúng**

**Fix:**
1. Check backend có log error khi gửi không
2. Verify FCM token trong database có đúng không
3. Test API endpoint:
   ```bash
   curl -X POST http://127.0.0.1:4000/notifications/fcm/send-token \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer YOUR_TOKEN" \
     -d '{"token":"FCM_TOKEN","title":"Test","body":"Test"}'
   ```

### Scenario B: Firebase Console test ❌ không nhận

**→ Vấn đề: App hoặc device config**

**Check:**

**iOS:**
- [ ] Test trên **real device** (simulator không support push)
- [ ] Settings → [App] → Notifications → Enabled
- [ ] Firebase Console → APNS Certificate uploaded
- [ ] Xcode → Push Notifications capability enabled

**Android:**
- [ ] Settings → Apps → [App] → Notifications → Enabled  
- [ ] Android 13+: Permission granted trong app
- [ ] `google-services.json` có trong `android/app/`

### Scenario C: Backend log ❌ Firebase not initialized

**→ Vấn đề: Backend config**

**Fix:**
1. Check `.env` file:
   ```
   FIREBASE_PROJECT_ID=sotaynamduoc
   FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxx@sotaynamduoc.iam.gserviceaccount.com
   FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n"
   ```
2. Restart backend: `npm run start`

---

## 📋 Nếu vẫn không được:

**Provide these:**
1. Platform: iOS hay Android?
2. Firebase Console test: Nhận được hay không?
3. Backend logs khi gửi
4. App logs khi nhận
5. Screenshot FCM Test Screen (Permission status)

**iOS Specific:**
6. Test trên real device hay simulator?
7. APNS certificate có trong Firebase Console không?

**Android Specific:**
6. Android version?
7. Permission granted trong Settings?

---

## 🔑 Most Common Issues (99% cases):

1. **❌ Permission denied** → Enable in Settings
2. **❌ iOS simulator** → Use real device
3. **❌ APNS certificate missing** → Upload to Firebase Console
4. **❌ Backend Firebase not init** → Check .env
5. **❌ Wrong FCM token** → Copy fresh token from logs

---

*Debug time: ~5 minutes*

