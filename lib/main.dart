import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sotaynamduoc/blocs/auth/auth_cubit.dart';
import 'package:sotaynamduoc/blocs/language_cubit.dart';
import 'package:sotaynamduoc/blocs/news/news_bloc.dart';
import 'package:sotaynamduoc/blocs/theme_cubit.dart';
import 'package:sotaynamduoc/domain/repositories/auth_repository.dart';
import 'package:sotaynamduoc/domain/repositories/news_repository.dart';
import 'package:sotaynamduoc/ui/app.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';
import 'package:sotaynamduoc/injection_container.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await getIt.init();
  String language = await SharedPreferenceUtil.getCurrentLanguage();
  String theme = await SharedPreferenceUtil.getCurrentTheme();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit(language)),
        BlocProvider(create: (_) => ThemeCubit(theme)),
        BlocProvider(create: (_) => NewsBloc(newsRepository: getIt.getIt.get<NewsRepository>())),
        BlocProvider(create: (_) => AuthCubit(repository: getIt.getIt.get<AuthRepository>())),
      ],
      child: MyApp(),
    ),
  );
}
