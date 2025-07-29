import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/domain/data/datasources/datasource.dart';
import 'package:sotaynamduoc/domain/network/network.dart';
import 'package:sotaynamduoc/domain/repositories/repositories.dart';
import 'package:get_it/get_it.dart';

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
  // bloc cubit
  registerCubit(getIt);
}

void registerCubit(GetIt getIt) {
  // getIt.registerLazySingleton(() => AuthCubit(repository: getIt.get()));
}

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
}

void registerDataSource(GetIt getIt) {
  getIt.registerLazySingleton(() => AuthRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(() => UserLocalDataSource());
  getIt.registerLazySingleton(() => UserRemoteDataSource(network: getIt.get()));
  getIt.registerLazySingleton(() => NewsRemoteDataSource(network: getIt.get()));
}

void registerNetwork(GetIt getIt) {
  getIt.registerLazySingleton(() => Network.instance());
}
