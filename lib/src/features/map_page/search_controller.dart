import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchNotifier extends StateNotifier<GeoPoint> {
  SearchNotifier() : super(_initialValue);
  static final _initialValue = GeoPoint(latitude: 0.0, longitude: 0.0);
  void move(GeoPoint location) {
    state = location;
  }
}
