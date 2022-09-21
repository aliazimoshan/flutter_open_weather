import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/current_weather.dart';
import 'package:open_weather_example_flutter/src/features/weather_page/hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  List<Color> colorCondition() {
    if (DateTime.now().hour <= 6) {
      return AppColors.dawnGradient;
    } else if (DateTime.now().hour <= 11) {
      return AppColors.morningGradient;
    } else if (DateTime.now().hour <= 16) {
      return AppColors.noonGradient;
    } else if (DateTime.now().hour <= 19) {
      return AppColors.eveningGradient;
    } else if (DateTime.now().hour <= 23) {
      return AppColors.nightGradient;
    } else {
      return AppColors.dawnGradient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: colorCondition(),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              //Spacer(),
              //CitySearchBox(),
              //Spacer(),
              CurrentWeather(),
              //Spacer(),
              HourlyWeather(),
              //Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
