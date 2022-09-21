import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/entities/weather/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/map_page/search_page.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/city_search_box.dart';
import 'package:open_weather_example_flutter/src/repositories/api_error.dart';
import 'package:open_weather_example_flutter/src/repositories/weather_repository.dart';

class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {required this.geoPoint})
      : super(const AsyncValue.loading()) {
    getWeather(geoPoint: geoPoint);
  }
  final HttpWeatherRepository _weatherRepository;
  final GeoPoint geoPoint;

  Future<void> getWeather({required GeoPoint geoPoint}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(geoPoint: geoPoint);
      state = AsyncValue.data(WeatherData.from(weather));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final geoPoint = ref.watch(searchProvider);
  return CurrentWeatherController(weatherRepository, geoPoint: geoPoint);
});
