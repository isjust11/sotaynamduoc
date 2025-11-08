import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  String? _baseUrl;

  void initialize() {
    _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl!,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ),
    );

    // Add auth interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String token = await SharedPreferenceUtil.getAccessToken();
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// Send FCM token to server
  Future<bool> sendFCMToken(String token) async {
    try {
      final platform = Platform.isIOS ? 'ios' : 'android';
      final response = await _dio.post(
        '/api/fcm/register-token',
        data: {'token': token, 'platform': platform, 'app_version': '1.0.0'},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sending FCM token: $e');
      return false;
    }
  }

  /// Subscribe to topic
  Future<bool> subscribeToTopic(String topic) async {
    try {
      final response = await _dio.post(
        '/api/fcm/subscribe-topic',
        data: {'topic': topic},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error subscribing to topic: $e');
      return false;
    }
  }

  /// Unsubscribe from topic
  Future<bool> unsubscribeFromTopic(String topic) async {
    try {
      final response = await _dio.post(
        '/api/fcm/unsubscribe-topic',
        data: {'topic': topic},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error unsubscribing from topic: $e');
      return false;
    }
  }

  /// Send test notification
  Future<bool> sendTestNotification(String title, String body) async {
    try {
      final response = await _dio.post(
        '/api/notifications/fcm/send-topic',
        data: {
          'topic': 'test',
          'title': title,
          'body': body,
          'data': {
            'type': 'test',
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          },
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sending test notification: $e');
      return false;
    }
  }
}
