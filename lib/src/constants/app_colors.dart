import 'dart:ui';

class AppColors {
  static const eveningGradient = [Color(0xff030632), Color(0xff4000A3)];
  static const morningGradient = [Color(0xff32D0FC), Color(0xff005CE0)];
  static const noonGradient = [Color(0xffFC9F32), Color(0xffD33A3A)];
  static const dawnGradient = [Color(0xff1C7891), Color(0xff162A2F)];
  static const nightGradient = [Color(0xff35416C), Color(0xff151515)];

  static const secondaryTextColor = Color(0x99ffffff);
  static const primaryTextColor = Color(0xFFFFFFFF);

  static List<Color> gradientColors() {
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
}
