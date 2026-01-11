import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/weather_local_datasource.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../presentation/bloc/weather/weather_bloc.dart';
import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Core - SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Core - Dio Client
  getIt.registerLazySingleton(() => DioClient());

  // Data Sources - Local
  getIt.registerLazySingleton<WeatherLocalDataSource>(
    () => WeatherLocalDataSourceImpl(
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  // Data Sources - Remote
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(
      getIt<DioClient>().dio,
    ),
  );

  // Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: getIt<WeatherRemoteDataSource>(),
      localDataSource: getIt<WeatherLocalDataSource>(),
    ),
  );

  // BLoC
  getIt.registerFactory(
    () => WeatherBloc(
      repository: getIt<WeatherRepository>(),
    ),
  );
}
