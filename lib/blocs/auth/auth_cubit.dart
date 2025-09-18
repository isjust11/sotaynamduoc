import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';
import 'package:sotaynamduoc/services/social_login_service.dart';

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
}
