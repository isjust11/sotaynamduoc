import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/blocs/utils.dart';
import 'package:sotaynamduoc/domain/data/models/models.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';

class UserInfoCubit extends Cubit<BaseState> {
  final UserRepository repository;

  UserInfoCubit({required this.repository}) : super(InitState());

  getUserInfo() async {
    try {
      emit(LoadingState());
      UserModel userModel = await repository.getUserInfo();
      emit(LoadedState(userModel));
    } catch (e) {
      if (e is NotFoundException) {
        // TODO handle for some case
      }
      emit(ErrorState(BlocUtils.getMessageError(e)));
    }
  }
}
