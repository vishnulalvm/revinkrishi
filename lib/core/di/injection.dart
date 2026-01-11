import 'package:get_it/get_it.dart';
import '../../data/datasources/weather_remote_datasource.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../presentation/bloc/weather/weather_bloc.dart';
import '../network/dio_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  // Core - Dio Client
  getIt.registerLazySingleton(() => DioClient());

  // Data Sources
  getIt.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(
      getIt<DioClient>().dio,
    ),
  );

  // Repositories
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: getIt<WeatherRemoteDataSource>(),
    ),
  );

  // BLoC
  getIt.registerFactory(
    () => WeatherBloc(
      repository: getIt<WeatherRepository>(),
    ),
  );
}
