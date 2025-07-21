import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/language_cubit.dart';
import 'package:sotaynamduoc/ui/app.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';
import 'package:sotaynamduoc/injection_container.dart' as getIt;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();
  String language = await SharedPreferenceUtil.getCurrentLanguage();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => LanguageCubit(language),
    ),
  ], child: MyApp()));
}