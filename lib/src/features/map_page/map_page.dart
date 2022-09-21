//import 'dart:async';
//import 'package:flutter/material.dart';
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
//import 'package:open_weather_example_flutter/src/features/map_page/search_page.dart';

//class MapPage extends StatefulWidget {
//  MapPage({Key? key}) : super(key: key);

//  @override
//  _MapPageState createState() => _MapPageState();
//}

//class _MapPageState extends State<MapPage> with OSMMixinObserver {
//  late MapController controller;
//  late GlobalKey<ScaffoldState> scaffoldKey;
//  Key mapGlobalkey = UniqueKey();
//  ValueNotifier<bool> zoomNotifierActivation = ValueNotifier(false);
//  ValueNotifier<bool> visibilityZoomNotifierActivation = ValueNotifier(false);
//  ValueNotifier<bool> advPickerNotifierActivation = ValueNotifier(false);
//  ValueNotifier<bool> trackingNotifier = ValueNotifier(false);
//  ValueNotifier<bool> showFab = ValueNotifier(true);
//  Timer? timer;
//  int x = 0;
//  ValueNotifier<GeoPoint?> notifier = ValueNotifier(null);

//  List<Color> colorCondition() {
//    if (DateTime.now().hour <= 6) {
//      return AppColors.dawnGradient;
//    } else if (DateTime.now().hour <= 11) {
//      return AppColors.morningGradient;
//    } else if (DateTime.now().hour <= 16) {
//      return AppColors.noonGradient;
//    } else if (DateTime.now().hour <= 19) {
//      return AppColors.eveningGradient;
//    } else if (DateTime.now().hour <= 23) {
//      return AppColors.nightGradient;
//    } else {
//      return AppColors.dawnGradient;
//    }
//  }

//  @override
//  void initState() {
//    super.initState();
//    controller = MapController(
//      initMapWithUserPosition: false,
//      initPosition: GeoPoint(
//        latitude: 47.4358055,
//        longitude: 8.4737324,
//      ),
//    );
//    controller.addObserver(this);
//    scaffoldKey = GlobalKey<ScaffoldState>();
//  }

//  Future<void> mapIsInitialized() async {
//    await controller.setZoom(zoomLevel: 12);
//  }

//  @override
//  Future<void> mapIsReady(bool isReady) async {
//    if (isReady) {
//      await mapIsInitialized();
//    }
//  }

//  @override
//  void dispose() {
//    if (timer != null && timer!.isActive) {
//      timer?.cancel();
//    }
//    //controller.listenerMapIsReady.removeListener(mapIsInitialized);
//    controller.dispose();
//    super.dispose();
//  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: scaffoldKey,
//      resizeToAvoidBottomInset: false,
//      appBar: AppBar(
//        title: const Text('Weather'),
//        flexibleSpace: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              colors: colorCondition(),
//            ),
//          ),
//        ),
//        actions: <Widget>[
//          IconButton(
//            onPressed: () async {
//              var p = await Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: ((context) => const SearchPage()),
//                  ));
//              if (p != null) {
//                print(p);
//                notifier.value = p as GeoPoint;
//              }
//            },
//            icon: Icon(Icons.search),
//          ),
//        ],
//      ),
//      body: Container(
//        child: Stack(
//          children: [
//            OSMFlutter(
//              controller: controller,
//              trackMyPosition: false,
//              androidHotReloadSupport: true,
//              mapIsLoading: Center(
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    CircularProgressIndicator(),
//                    Text("Map is Loading.."),
//                  ],
//                ),
//              ),
//              onMapIsReady: (isReady) {
//                if (isReady) {
//                  print("map is ready");
//                }
//              },
//              initZoom: 8,
//              minZoomLevel: 3,
//              maxZoomLevel: 18,
//              stepZoom: 1.0,
//              showContributorBadgeForOSM: true,
//              showDefaultInfoWindow: false,
//              onLocationChanged: (myLocation) {
//                print(myLocation);
//              },
//              onGeoPointClicked: (geoPoint) async {
//                if (geoPoint ==
//                    GeoPoint(latitude: 47.442475, longitude: 8.4680389)) {
//                  await controller.setMarkerIcon(
//                      geoPoint,
//                      MarkerIcon(
//                        icon: Icon(
//                          Icons.bus_alert,
//                          color: Colors.blue,
//                          size: 24,
//                        ),
//                      ));
//                }
//                ScaffoldMessenger.of(context).showSnackBar(
//                  SnackBar(
//                    content: Text(
//                      "${geoPoint.toMap().toString()}",
//                    ),
//                    action: SnackBarAction(
//                      onPressed: () =>
//                          ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//                      label: "hide",
//                    ),
//                  ),
//                );
//              },
//            ),
//            Positioned(
//              bottom: 10,
//              left: 10,
//              child: ValueListenableBuilder<bool>(
//                valueListenable: advPickerNotifierActivation,
//                builder: (ctx, visible, child) {
//                  return Visibility(
//                    visible: visible,
//                    child: AnimatedOpacity(
//                      opacity: visible ? 1.0 : 0.0,
//                      duration: Duration(milliseconds: 500),
//                      child: child,
//                    ),
//                  );
//                },
//                child: FloatingActionButton(
//                  key: UniqueKey(),
//                  child: Icon(Icons.arrow_forward),
//                  heroTag: "confirmAdvPicker",
//                  onPressed: () async {
//                    advPickerNotifierActivation.value = false;
//                    GeoPoint p =
//                        await controller.selectAdvancedPositionPicker();
//                    print(p);
//                  },
//                ),
//              ),
//            ),
//            Positioned(
//              bottom: 10,
//              left: 10,
//              child: ValueListenableBuilder<bool>(
//                valueListenable: visibilityZoomNotifierActivation,
//                builder: (ctx, visibility, child) {
//                  return Visibility(
//                    visible: visibility,
//                    child: child!,
//                  );
//                },
//                child: ValueListenableBuilder<bool>(
//                  valueListenable: zoomNotifierActivation,
//                  builder: (ctx, isVisible, child) {
//                    return AnimatedOpacity(
//                      opacity: isVisible ? 1.0 : 0.0,
//                      onEnd: () {
//                        visibilityZoomNotifierActivation.value = isVisible;
//                      },
//                      duration: Duration(milliseconds: 500),
//                      child: child,
//                    );
//                  },
//                  child: Column(
//                    children: [
//                      ElevatedButton(
//                        child: Icon(Icons.add),
//                        onPressed: () async {
//                          controller.zoomIn();
//                        },
//                      ),
//                      ElevatedButton(
//                        child: Icon(Icons.remove),
//                        onPressed: () async {
//                          controller.zoomOut();
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: ValueListenableBuilder<bool>(
//        valueListenable: showFab,
//        builder: (ctx, isShow, child) {
//          if (!isShow) {
//            return SizedBox.shrink();
//          }
//          return child!;
//        },
//        child: FloatingActionButton(
//          onPressed: () async {
//            if (!trackingNotifier.value) {
//              await controller.currentLocation();
//              await controller.enableTracking();
//              //await controller.zoom(5.0);
//            } else {
//              await controller.disabledTracking();
//            }
//            trackingNotifier.value = !trackingNotifier.value;
//          },
//          child: ValueListenableBuilder<bool>(
//            valueListenable: trackingNotifier,
//            builder: (ctx, isTracking, _) {
//              if (isTracking) {
//                return Icon(Icons.gps_off_sharp);
//              }
//              return Icon(Icons.my_location);
//            },
//          ),
//        ),
//      ),
//    );
//  }

//  @override
//  Future<void> mapRestored() async {
//    super.mapRestored();
//    print("log map restored");
//  }
//}
