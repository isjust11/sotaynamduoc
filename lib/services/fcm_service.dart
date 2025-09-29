import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sotaynamduoc/services/api_service.dart';

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final GetStorage _storage = GetStorage();

  // Notification channels
  static const String _channelId = 'sotaynamduoc_channel';
  static const String _channelName = 'Sổ Tay Nam Dược';
  static const String _channelDescription =
      'Thông báo từ ứng dụng Sổ Tay Nam Dược';

  // Storage keys
  static const String _fcmTokenKey = 'fcm_token';
  static const String _notificationsEnabledKey = 'notifications_enabled';

  String? _fcmToken;
  bool _notificationsEnabled = true;

  String? get fcmToken => _fcmToken;
  bool get notificationsEnabled => _notificationsEnabled;

  // Temporarily disable APNs-dependent logic on iOS when Apple push
  // certificates/keys are not yet configured.
  static const bool kDisableIosApns = true;

  /// Initialize FCM service
  Future<void> initialize() async {
    try {
      // Initialize Firebase
      await Firebase.initializeApp();

      // Initialize local notifications
      await _initializeLocalNotifications();

      // Request permission
      await _requestPermission();

      // For iOS, ensure APNS token is ready before getting FCM token
      if (Platform.isIOS && !kDisableIosApns) {
        await _ensureAPNSTokenReady();
      }

      // Get FCM token
      await _getFCMToken();

      // Setup message handlers
      _setupMessageHandlers();

      // Load notification settings
      await _loadNotificationSettings();

      debugPrint('FCM Service initialized successfully');
    } catch (e) {
      debugPrint('Error initializing FCM Service: $e');
    }
  }

  /// Ensure APNS token is ready for iOS
  Future<void> _ensureAPNSTokenReady() async {
    int retryCount = 0;
    const maxRetries = 5;

    while (retryCount < maxRetries) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken != null) {
        debugPrint('APNS Token ready: $apnsToken');
        return;
      }

      retryCount++;
      debugPrint('APNS Token not ready, retry $retryCount/$maxRetries...');
      await Future.delayed(Duration(seconds: retryCount));
    }

    debugPrint(
      'APNS Token not available after $maxRetries retries, proceeding...',
    );
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
        playSound: true,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);
    }
  }

  /// Request notification permission
  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );

    // For iOS, ensure APNS token is available
    if (Platform.isIOS && !kDisableIosApns) {
      await _setupAPNSToken();
    }
  }

  /// Setup APNS token for iOS
  Future<void> _setupAPNSToken() async {
    try {
      // Request APNS token
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken != null) {
        debugPrint('APNS Token: $apnsToken');
      } else {
        debugPrint('APNS Token not available yet, will retry...');
        // Retry after a short delay
        Future.delayed(const Duration(seconds: 2), () async {
          final retryToken = await _messaging.getAPNSToken();
          if (retryToken != null) {
            debugPrint('APNS Token (retry): $retryToken');
          }
        });
      }
    } catch (e) {
      debugPrint('Error getting APNS token: $e');
    }
  }

  /// Get FCM token
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _messaging.getToken();
      if (_fcmToken != null) {
        await _storage.write(_fcmTokenKey, _fcmToken);
        debugPrint('FCM Token: $_fcmToken');

        // Send token to server
        await _sendTokenToServer(_fcmToken!);
      }
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  /// Send FCM token to server
  Future<void> _sendTokenToServer(String token) async {
    try {
      final apiService = ApiService();
      apiService.initialize();
      final success = await apiService.sendFCMToken(token);
      if (success) {
        debugPrint('FCM token sent to server: $token');
      } else {
        debugPrint('Failed to send FCM token to server');
      }
    } catch (e) {
      debugPrint('Error sending FCM token to server: $e');
    }
  }

  /// Setup message handlers
  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle notification tap when app is terminated
    _handleInitialMessage();
  }

  /// Handle foreground messages
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Received foreground message: ${message.messageId}');

    if (!_notificationsEnabled) return;

    // Show local notification
    await _showLocalNotification(message);
  }

  /// Handle background messages
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    debugPrint('Received background message: ${message.messageId}');
    // Background message handling is done here
  }

  /// Handle notification tap
  Future<void> _handleNotificationTap(RemoteMessage message) async {
    debugPrint('Notification tapped: ${message.messageId}');
    // Handle navigation based on message data
    _navigateToScreen(message.data);
  }

  /// Handle initial message (when app is terminated)
  Future<void> _handleInitialMessage() async {
    final RemoteMessage? message = await _messaging.getInitialMessage();
    if (message != null) {
      debugPrint('App opened from notification: ${message.messageId}');
      _navigateToScreen(message.data);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          _channelId,
          _channelName,
          channelDescription: _channelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Local notification tapped: ${response.payload}');
    // Handle navigation based on payload
  }

  /// Navigate to specific screen based on message data
  void _navigateToScreen(Map<String, dynamic> data) {
    // TODO: Implement navigation logic based on message data
    // Example:
    // if (data['screen'] == 'profile') {
    //   Get.toNamed('/profile');
    // }
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      if (Platform.isIOS && kDisableIosApns) {
        debugPrint(
          'APNS disabled on iOS: skipping topic subscription for "$topic"',
        );
        return;
      }
      // For iOS, ensure APNS token is available before subscribing
      if (Platform.isIOS) {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null) {
          debugPrint('APNS token not available, waiting...');
          // Wait a bit and retry
          await Future.delayed(const Duration(seconds: 3));
          final retryToken = await _messaging.getAPNSToken();
          if (retryToken == null) {
            debugPrint('APNS token still not available, proceeding anyway...');
          }
        }
      }

      await _messaging.subscribeToTopic(topic);

      // Also notify server
      final apiService = ApiService();
      apiService.initialize();
      await apiService.subscribeToTopic(topic);

      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic $topic: $e');

      // If it's an APNS error, try to get the token and retry
      if (e.toString().contains('apns-token-not-set') && Platform.isIOS) {
        debugPrint('Retrying subscription after APNS token setup...');
        await Future.delayed(const Duration(seconds: 2));
        try {
          await _messaging.subscribeToTopic(topic);
          debugPrint('Successfully subscribed to topic: $topic (retry)');
        } catch (retryError) {
          debugPrint('Retry failed: $retryError');
        }
      }
    }
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);

      // Also notify server
      final apiService = ApiService();
      apiService.initialize();
      await apiService.unsubscribeFromTopic(topic);

      debugPrint('Unsubscribed from topic: $topic');
    } catch (e) {
      debugPrint('Error unsubscribing from topic $topic: $e');
    }
  }

  /// Toggle notifications
  Future<void> toggleNotifications(bool enabled) async {
    _notificationsEnabled = enabled;
    await _storage.write(_notificationsEnabledKey, enabled);

    if (enabled) {
      await _requestPermission();
    }
  }

  /// Load notification settings
  Future<void> _loadNotificationSettings() async {
    _notificationsEnabled = _storage.read(_notificationsEnabledKey) ?? true;
  }

  /// Refresh FCM token
  Future<void> refreshToken() async {
    await _getFCMToken();
  }

  /// Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _messaging.getNotificationSettings();
  }

  /// Check APNS token status (iOS only)
  Future<bool> isAPNSTokenReady() async {
    if (!Platform.isIOS) return true;
    if (kDisableIosApns) return false;

    try {
      final apnsToken = await _messaging.getAPNSToken();
      return apnsToken != null;
    } catch (e) {
      debugPrint('Error checking APNS token: $e');
      return false;
    }
  }

  /// Get APNS token (iOS only)
  Future<String?> getAPNSToken() async {
    if (!Platform.isIOS) return null;
    if (kDisableIosApns) return null;

    try {
      return await _messaging.getAPNSToken();
    } catch (e) {
      debugPrint('Error getting APNS token: $e');
      return null;
    }
  }
}
