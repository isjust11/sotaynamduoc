import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

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
}
