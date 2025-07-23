import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class LoginCubit extends Cubit<BaseState> {
  final AuthRepository repository;

  LoginCubit({required this.repository}) : super(InitState());

  doLogin({String? userName, String? password}) async {
    try {
      emit(LoadingState());
      UserModel userModel = await repository.login({
        "username": userName,
        "password": password,
      });
      emit(LoadedState(userModel));
    } catch (e) {
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }
}
