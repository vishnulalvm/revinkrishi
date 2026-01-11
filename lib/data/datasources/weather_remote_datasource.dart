import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/weather_model.dart';

part 'weather_remote_datasource.g.dart';

@RestApi()
abstract class WeatherRemoteDataSource {
  factory WeatherRemoteDataSource(Dio dio, {String baseUrl}) =
      _WeatherRemoteDataSource;

  @GET('/data/3.0/onecall')
  Future<WeatherModel> getWeather({
    @Query('lat') required double lat,
    @Query('lon') required double lon,
    @Query('appid') required String apiKey,
    @Query('units') String units = 'metric',
    @Query('exclude') String exclude = 'minutely,hourly,alerts',
  });
}
