import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/blocs/discovery/discovery_bloc.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/domain/repositories/fcm_repository.dart';
import 'package:sotaynamduoc/ui/app.dart';
import 'package:sotaynamduoc/utils/shared_preference.dart';
import 'package:sotaynamduoc/injection_container.dart' as getIt;
import 'package:sotaynamduoc/services/fcm_service.dart';
import 'package:sotaynamduoc/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await getIt.init();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize FCM Service
  await FCMService(
    fcmRepository: getIt.getIt.get<FcmRepository>(),
  ).initialize();

  String language = await SharedPreferenceUtil.getCurrentLanguage();
  String theme = await SharedPreferenceUtil.getCurrentTheme();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit(language)),
        BlocProvider(create: (_) => ThemeCubit(theme)),
        BlocProvider(
          create: (_) =>
              NewsBloc(newsRepository: getIt.getIt.get<NewsRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              AuthCubit(repository: getIt.getIt.get<AuthRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              CategoryCubit(repository: getIt.getIt.get<CategoryRepository>()),
        ),
        BlocProvider(
          create: (_) => FolkMedicineBloc(
            folkMedicineRepository: getIt.getIt.get<FolkMedicineRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) =>
              HerbalBloc(repository: getIt.getIt.get<HerbalRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              AuthorBloc(repository: getIt.getIt.get<AuthorRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              PageCubit(repository: getIt.getIt.get<PageRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              FeedbackCubit(repository: getIt.getIt.get<FeedbackRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              MediaCubit(repository: getIt.getIt.get<MediaRepository>()),
        ),
        BlocProvider(
          create: (_) => UserInteractionCubit(
            repository: getIt.getIt.get<UserInteractionRepository>(),
          ),
        ),
        BlocProvider(
          create: (_) =>
              KnowledgeBloc(newsRepository: getIt.getIt.get<NewsRepository>()),
        ),
        BlocProvider(
          create: (_) =>
              TipBloc(tipRepository: getIt.getIt.get<TipRepository>()),
        ),
        BlocProvider(
          create: (_) => DiscoveryBloc(
            newsRepository: getIt.getIt.get<NewsRepository>(),
            categoryRepository: getIt.getIt.get<CategoryRepository>(),
            herbalRepository: getIt.getIt.get<HerbalRepository>(),
            authorRepository: getIt.getIt.get<AuthorRepository>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
