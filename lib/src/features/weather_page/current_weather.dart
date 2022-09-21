import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/entities/weather/weather_data.dart';
import 'package:open_weather_example_flutter/src/features/map_page/map_page.dart';
import 'package:open_weather_example_flutter/src/features/map_page/search_page.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/city_search_box.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/current_weather_controller.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);

    return weatherDataValue.when(
      data: (weatherData) => CurrentWeatherContents(data: weatherData),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, __) => Text(e.toString()),
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key? key, required this.data})
      : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);

    final temp = '${data.temp.celsius.toInt().toString()}°';
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = '$maxTemp°/$minTemp°';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 40,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                children: [
                  Text(
                    temp,
                    style: const TextStyle(
                      color: AppColors.primaryTextColor,
                      fontSize: 70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    highAndLow,
                    style: const TextStyle(
                      color: AppColors.secondaryTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            city,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            WeatherIconImage(
              iconUrl: data.iconUrl,
              size: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
