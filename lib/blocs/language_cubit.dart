import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit(super.language);

  void changeLanguage(String language) async {
    // Save to shared preferences
    await SharedPreferenceUtil.setCurrentLanguage(language);
    // Emit the new language state - this will trigger rebuild of MaterialApp
    emit(language);
  }
}
