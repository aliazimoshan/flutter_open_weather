import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/entities/forecast/forecast_data.dart';
import 'package:open_weather_example_flutter/src/features/map_page/search_page.dart';
import 'package:open_weather_example_flutter/src/repositories/api_error.dart';
import 'package:open_weather_example_flutter/src/repositories/weather_repository.dart';

class HourlyWeatherController extends StateNotifier<AsyncValue<ForecastData>> {
  HourlyWeatherController(this._weatherRepository, {required GeoPoint geoPoint})
      : super(const AsyncValue.loading()) {
    getWeather(geoPoint: geoPoint);
  }
  final HttpWeatherRepository _weatherRepository;

  Future<void> getWeather({required GeoPoint geoPoint}) async {
    try {
      state = const AsyncValue.loading();
      final forecast = await _weatherRepository.getForecast(geoPoint: geoPoint);
      state = AsyncValue.data(ForecastData.from(forecast));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final hourlyWeatherControllerProvider = StateNotifierProvider.autoDispose<
    HourlyWeatherController, AsyncValue<ForecastData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final geoPoint = ref.watch(searchProvider);
  return HourlyWeatherController(weatherRepository, geoPoint: geoPoint);
});
