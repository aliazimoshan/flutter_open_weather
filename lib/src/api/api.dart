import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

/// Uri builder class for the OpenWeatherMap API
class OpenWeatherMapAPI {
  OpenWeatherMapAPI(this.apiKey);
  final String apiKey;

  static const String _apiBaseUrl = "api.openweathermap.org";
  static const String _apiPath = "/data/2.5/";

  Uri weather(GeoPoint geoPoint) => _buildUri(
        endpoint: "weather",
        parametersBuilder: () => cityQueryParameters(geoPoint),
      );

  Uri forecast(GeoPoint geoPoint) => _buildUri(
        endpoint: "forecast",
        parametersBuilder: () => cityQueryParameters(geoPoint),
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  Map<String, dynamic> cityQueryParameters(GeoPoint geoPoint) => {
        "lat": geoPoint.latitude.toString(),
        "lon": geoPoint.longitude.toString(),
        "appid": apiKey,
        "units": "metric",
      };
}
