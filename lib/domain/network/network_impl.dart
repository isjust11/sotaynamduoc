import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sotaynamduoc/domain/network/network.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/utils/navigator.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class Network {
  static const int DEFAULT_TIMEOUT = 30000; // Tăng timeout lên 30 giây
  static BaseOptions options = BaseOptions(
    connectTimeout: DEFAULT_TIMEOUT,
    receiveTimeout: DEFAULT_TIMEOUT,
    sendTimeout: DEFAULT_TIMEOUT, // Thêm sendTimeout
    baseUrl: ApiConstant.apiHost,
  );
  static final Dio _dio = Dio(options);
  static bool _isRefreshing = false;

  Network._internal() {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions myOption, RequestInterceptorHandler handler) async {
              final String token = await SharedPreferenceUtil.getAccessToken();
              if (token.isNotEmpty) {
                myOption.headers["Authorization"] = "Bearer $token";
              }
              return handler.next(myOption);
            },
      ),
    );
  }

  static Network instance() {
    return Network._internal();
  }

  Future<ApiResponse> get({
    required String url,
    Map<String, dynamic>? params,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: BaseParamRequest.request(params),
        options: Options(responseType: ResponseType.json),
      );
      return getApiResponse(response);
    } on DioError catch (e) {
      //handle error khác
      if (kDebugMode) {
        print("DioError GET: ${e.toString()}");
      }
      return getError(e);
    }
  }

  Future<ApiResponse> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic> params = const {},
    String contentType = Headers.jsonContentType,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: BaseParamRequest.request(body),
        queryParameters: params,
        options: Options(
          responseType: ResponseType.json,
          contentType: contentType,
        ),
      );
      return getApiResponse(response);
    } on DioError catch (e) {
      if (kDebugMode) {
        print("DioError POST: ${e.toString()}");
      }
      return getError(e);
    }
  }

  ApiResponse getError(DioError e) {
    if (e.response?.statusCode == 401) {
      handleTokenExpired();
    }
    switch (e.type) {
      case DioErrorType.cancel:
        return ApiResponse.error("Request cancelled");
      case DioErrorType.connectTimeout:
        return ApiResponse.error(
          "Connection timeout - check network connection",
        );
      case DioErrorType.receiveTimeout:
        return ApiResponse.error("Receive timeout - server response too slow");
      case DioErrorType.sendTimeout:
        return ApiResponse.error("Send timeout - check network speed");
      case DioErrorType.other:
        // Kiểm tra chi tiết lỗi network
        if (e.message.contains('SocketException') ||
            e.message.contains('Network is unreachable') ||
            e.message.contains('No route to host')) {
          return ApiResponse.error(
            "Network error - check internet connection and API URL",
          );
        }
        return ApiResponse.error("Network error: ${e.message}");
      default:
        return ApiResponse.error(
          e.message,
          data: getDataReplace(e.response?.data),
          code: e.response?.statusCode,
        );
    }
  }

  ApiResponse getApiResponse(Response response) {
    return ApiResponse.success(
      data: response.data,
      code: response.statusCode,
      status: response.statusCode,
      message: response.statusMessage ?? "",
    );
  }

  Future<bool> _refreshToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;
    try {
      final String refreshToken = await SharedPreferenceUtil.getRefreshToken();
      if (refreshToken.isEmpty) {
        _forceLogout();
        return false;
      }

      // Sử dụng một Dio riêng không có interceptor để tránh vòng lặp 401
      final Dio refreshDio = Dio(options);
      final Response response = await refreshDio.post(
        ApiConstant.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(responseType: ResponseType.json),
      );

      final data = response.data;
      final String newAccessToken = data['accessToken'] ?? '';
      final String newRefreshToken = data['refreshToken'] ?? '';
      if (newAccessToken.isEmpty || newRefreshToken.isEmpty) {
        _forceLogout();
        return false;
      }

      await SharedPreferenceUtil.saveAccessToken(newAccessToken);
      await SharedPreferenceUtil.saveRefreshToken(newRefreshToken);
      return true;
    } catch (err) {
      if (kDebugMode) {
        print('Refresh token failed: $err');
      }
      _forceLogout();
      return false;
    } finally {
      _isRefreshing = false;
    }
  }

  void handleTokenExpired() async {
    await _refreshToken();
  }

  Future<void> _forceLogout() async {
    await SharedPreferenceUtil.clearData();
  }

  getDataReplace(data) {
    if (data is String) {
      return data.replaceAll("loi:", "").replaceAll(":loi", "").trim();
    }
    return data;
  }
}
