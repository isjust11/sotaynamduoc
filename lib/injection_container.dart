import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/data/datasources/remote/fcm_remote_data_source.dart';
import 'package:sotaynamduoc/domain/network/network.dart';
import 'package:sotaynamduoc/domain/repositories/fcm_repository.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:sotaynamduoc/blocs/search/search.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;
/*
Factory — Creates a new instance in every call
Singleton — Creates only one instance and reuses it every call

Register
Instance will be created as soon as registered, call of [get]
      getIt.registerSingleton(Network.instance());
      getIt.registerFactory(() => Network.instance());

lazyRegister
An instance will only be created when It’s called for the first time
     getIt.registerLazySingleton(() => Network.instance());

registerAsync
register class with async operator and create it
    getIt.registerSingletonAsync(() async {
      return await Network.instance();
    });
User
    Network network = getIt.get();
   // or
  Network network = getIt.get<Network>();

*/
Future<void> init({GetIt? getIt}) async {
  getIt ??= GetIt.instance;
  // network
  registerNetwork(getIt);
  // data source
  registerDataSource(getIt);
  // repositories
  registerRepositories(getIt);
  // shared preferences
  await registerSharedPreferences(getIt);
  // bloc cubit
  registerBlocs(getIt);
}

// void registerCubit(GetIt getIt) {
//   // getIt.registerLazySingleton(() => AuthCubit(repository: getIt.get()));
//   getIt.registerLazySingleton(() => HerbalBloc(repository: getIt.get()));
// }

void registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton(
    () => AuthRepository(
      remoteDataSource: getIt.get(),
      localDataSource: getIt.get(),
    ),
  );
  getIt.registerLazySingleton(
    () => UserRepository(
      userLocalDataSource: getIt.get(),
      userRemoteDataSource: getIt.get(),
    ),
  );
  getIt.registerLazySingleton(
    () => NewsRepository(remoteDataSource: getIt.get()),
  );

  getIt.registerLazySingleton(
    () => CategoryRepository(remoteDataSource: getIt.get()),
  );

  getIt.registerLazySingleton(
    () => FolkMedicineRepository(remoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => HerbalRepository(remoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(() => AuthorRepository(dataSource: getIt.get()));
  getIt.registerLazySingleton(
    () => PageRepository(pageRemoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => FeedbackRepository(remoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => MediaRepository(remoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => UserInteractionRepository(remoteDataSource: getIt.get()),
  );
  getIt.registerLazySingleton(() => TipRepository(dataSource: getIt.get()));
  getIt.registerLazySingleton(
    () => FcmRepository(remoteDataSource: getIt.get()),
  );
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton(() => AuthRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(() => UserLocalDataSource());
  getIt.registerLazySingleton(() => UserRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(() => NewsRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(
    () => CategoryRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => FolkMedicineRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => HerbalRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => AuthorRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(() => PageRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(
    () => FeedbackRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => MediaRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(
    () => UserInteractionRemoteDataSource(network: getIt.get()),
  );
  getIt.registerLazySingleton(() => TipDataSource(network: getIt.get()));
  getIt.registerLazySingleton(() => FcmRemoteDataSource(network: getIt.get()));
}

void registerNetwork(GetIt getIt) {
  getIt.registerLazySingleton(() => Network.instance());
}

Future<void> registerSharedPreferences(GetIt getIt) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}

void registerBlocs(GetIt getIt) {
  getIt.registerLazySingleton(
    () => SearchBloc(
      newsRepository: getIt.get(),
      herbalRepository: getIt.get(),
      folkMedicineRepository: getIt.get(),
      sharedPreferences: getIt.get(),
    ),
  );
}
