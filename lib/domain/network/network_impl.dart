import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sotaynamduoc/domain/network/network.dart';
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
  static final List<RequestOptions> _requestQueue = [];
  static Completer<bool>? _refreshCompleter;

  Network._internal() {
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(responseBody: true, requestHeader: true),
      );
    }
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest:
            (RequestOptions options, RequestInterceptorHandler handler) async {
              final String token = await SharedPreferenceUtil.getAccessToken();
              if (token.isNotEmpty) {
                options.headers["Authorization"] = "Bearer $token";
              }
              return handler.next(options);
            },
        onError: (DioError error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            // Nếu đang refresh token, thêm request vào queue
            if (_isRefreshing) {
              _requestQueue.add(error.requestOptions);
              return handler.next(error);
            }

            // Bắt đầu refresh token
            final bool refreshSuccess = await _refreshToken();

            if (refreshSuccess) {
              // Retry request gốc với token mới
              try {
                final String newToken =
                    await SharedPreferenceUtil.getAccessToken();
                error.requestOptions.headers["Authorization"] =
                    "Bearer $newToken";

                final Dio retryDio = Dio(options);
                final Response response = await retryDio.fetch(
                  error.requestOptions,
                );
                return handler.resolve(response);
              } catch (retryError) {
                if (kDebugMode) {
                  print('Retry request failed: $retryError');
                }
                return handler.next(error);
              }
            } else {
              // Refresh thất bại, logout
              _forceLogout();
              return handler.next(error);
            }
          }
          return handler.next(error);
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
          e.response?.data["message"] ?? e.message,
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
    if (_isRefreshing) {
      // Nếu đang refresh, chờ kết quả
      return await _refreshCompleter?.future ?? false;
    }

    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();

    try {
      final String refreshToken = await SharedPreferenceUtil.getRefreshToken();
      if (refreshToken.isEmpty) {
        _forceLogout();
        _refreshCompleter!.complete(false);
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
        _refreshCompleter!.complete(false);
        return false;
      }

      await SharedPreferenceUtil.saveAccessToken(newAccessToken);
      await SharedPreferenceUtil.saveRefreshToken(newRefreshToken);

      // Xử lý queue requests
      await _processRequestQueue();

      _refreshCompleter!.complete(true);
      return true;
    } catch (err) {
      if (kDebugMode) {
        print('Refresh token failed: $err');
      }
      _forceLogout();
      _refreshCompleter!.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  Future<void> _processRequestQueue() async {
    final List<RequestOptions> queue = List.from(_requestQueue);
    _requestQueue.clear();

    for (final requestOptions in queue) {
      try {
        final String newToken = await SharedPreferenceUtil.getAccessToken();
        requestOptions.headers["Authorization"] = "Bearer $newToken";

        final Dio retryDio = Dio(options);
        await retryDio.fetch(requestOptions);
      } catch (e) {
        if (kDebugMode) {
          print('Retry request failed: $e');
        }
      }
    }
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
