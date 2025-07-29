
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class ThemeCubit extends Cubit<String> {
  ThemeCubit(super.theme);

  void changeTheme(String theme) async {
    await SharedPreferenceUtil.setCurrentTheme(theme);
    emit(theme);
  }
}
