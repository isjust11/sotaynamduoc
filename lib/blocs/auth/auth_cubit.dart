import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';
import 'package:sotaynamduoc/services/social_login_service.dart';
import 'package:sotaynamduoc/services/biometric_auth_service.dart';

class AuthCubit extends Cubit<BaseState> {
  final AuthRepository repository;

  AuthCubit({required this.repository}) : super(InitState());

  Future doLogin({String? userName, String? password}) async {
    try {
      emit(LoadingState());
      AuthModel userModel = await repository.login({
        "username": userName,
        "password": password,
      });

      emit(LoadedState(userModel));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future doLogout() async {
    try {
      emit(LoadingState());
      await SharedPreferenceUtil.clearData();
      emit(LoadedState(null));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future getProfile() async {
    try {
      emit(LoadingState());
      final profile = await repository.getProfile();
      emit(LoadedState(profile));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future doForgotPassword({String? userName}) async {
    try {
      emit(LoadingState());
      // await repository.forgotPassword(userName);
      emit(LoadedState(null));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future doRegister({
    String? fullName,
    String? email,
    String? phone,
    String? userName,
    String? password,
  }) async {
    try {
      emit(LoadingState());
      var result = await repository.register({
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "username": userName,
        "password": password,
      });

      emit(LoadedState(result));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future verifyPin({required String email, required String pin}) async {
    try {
      emit(LoadingState());
      var result = await repository.verifyPin({"email": email, "pin": pin});

      emit(LoadedState(result));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future resendPin({required String email}) async {
    try {
      emit(LoadingState());
      var result = await repository.resendPin({"email": email});

      emit(LoadedState(result));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future doGoogleLogin() async {
    try {
      emit(LoadingState());

      // Kiểm tra Google Play Services trước
      final bool isGooglePlayServicesAvailable =
          await SocialLoginService.isGooglePlayServicesAvailable();

      if (!isGooglePlayServicesAvailable) {
        emit(
          ErrorState(
            'Google Play Services không khả dụng. Vui lòng thử trên thiết bị thật hoặc cài đặt Google Play Services trong LDPlayer.',
          ),
        );
        return;
      }

      // Test configuration first
      await SocialLoginService.testGoogleSignInConfig();

      final socialData = await SocialLoginService.signInWithGoogle();
      if (socialData == null) {
        emit(InitState()); // User cancelled
        return;
      }

      AuthModel authModel = await repository.mobileSocialLogin(socialData);
      emit(LoadedState(authModel));
    } catch (e) {
      String errorMessage = BlocUtils.getMessageError(e);

      // Xử lý lỗi cụ thể cho Google Sign-In
      if (e.toString().contains('timeout') ||
          e.toString().contains('SERVICE_DISABLED') ||
          e.toString().contains('SERVICE_MISSING')) {
        errorMessage =
            'Google Play Services không khả dụng trên LDPlayer. Vui lòng thử trên thiết bị thật.';
      } else if (e.toString().contains('network_error')) {
        errorMessage = 'Lỗi kết nối mạng. Vui lòng kiểm tra kết nối internet.';
      }

      emit(ErrorState(errorMessage));
    }
  }

  Future doFacebookLogin() async {
    try {
      emit(LoadingState());

      final socialData = await SocialLoginService.signInWithFacebook();
      if (socialData == null) {
        emit(InitState()); // User cancelled
        return;
      }

      AuthModel authModel = await repository.mobileSocialLogin(socialData);
      emit(LoadedState(authModel));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  Future doMobileSocialLogin({
    required String platformId,
    required String email,
    required String fullName,
    required String platform,
    required String accessToken, // Bây giờ là required
    String? picture,
  }) async {
    try {
      emit(LoadingState());
      AuthModel authModel = await repository.mobileSocialLogin({
        "platformId": platformId,
        "email": email,
        "fullName": fullName,
        "platform": platform,
        "picture": picture,
        "accessToken": accessToken, // Required cho token verification
      });
      emit(LoadedState(authModel));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Đăng nhập bằng sinh trắc học
  Future doBiometricLogin() async {
    try {
      emit(LoadingState());

      final result = await BiometricAuthService.loginWithBiometrics();
      if (result.isSuccess && result.data != null) {
        // Sử dụng thông tin đăng nhập đã lưu để đăng nhập
        final credentials = result.data!;
        await doLogin(
          userName: credentials['username'],
          password: credentials['password'],
        );
      } else {
        emit(ErrorState(result.message ?? 'Đăng nhập sinh trắc học thất bại'));
      }
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }

  /// Bật/tắt sinh trắc học và lưu thông tin đăng nhập
  Future toggleBiometric(
    bool enabled, {
    String? username,
    String? password,
  }) async {
    try {
      if (enabled) {
        // Kiểm tra khả năng sinh trắc học
        final capability =
            await BiometricAuthService.checkBiometricCapability();
        if (capability != BiometricCapability.available) {
          String message;
          switch (capability) {
            case BiometricCapability.notSupported:
              message = 'Thiết bị không hỗ trợ sinh trắc học';
              break;
            case BiometricCapability.notEnrolled:
              message =
                  'Chưa thiết lập sinh trắc học. Vui lòng thiết lập trong Cài đặt thiết bị';
              break;
            case BiometricCapability.notAvailable:
              message = 'Sinh trắc học không khả dụng';
              break;
            default:
              message = 'Lỗi không xác định';
          }
          throw Exception(message);
        }

        // Xác thực sinh trắc học trước khi bật
        final authResult =
            await BiometricAuthService.authenticateWithBiometrics(
              localizedReason: 'Xác thực để bật đăng nhập bằng sinh trắc học',
            );

        if (!authResult.isSuccess) {
          throw Exception(
            authResult.message ?? 'Xác thực sinh trắc học thất bại',
          );
        }

        // Lưu thông tin đăng nhập nếu có
        if (username != null && password != null) {
          await BiometricAuthService.storeCredentials(username, password);
        }

        // Bật sinh trắc học
        await BiometricAuthService.setBiometricEnabledInApp(true);
      } else {
        // Tắt sinh trắc học và xóa thông tin đăng nhập
        await BiometricAuthService.setBiometricEnabledInApp(false);
        await BiometricAuthService.clearStoredCredentials();
      }
    } catch (e) {
      throw Exception(BlocUtils.getMessageError(e));
    }
  }

  /// Kiểm tra trạng thái sinh trắc học
  Future<bool> isBiometricEnabled() async {
    return await BiometricAuthService.isBiometricEnabledInApp();
  }

  /// Kiểm tra khả năng sử dụng sinh trắc học
  Future<BiometricCapability> checkBiometricCapability() async {
    return await BiometricAuthService.checkBiometricCapability();
  }
}
