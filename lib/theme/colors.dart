import 'package:flutter/material.dart';

LinearGradient linearColor() {
  return LinearGradient(
    colors: AppColors.colors,
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: const [0.4, 0.7],
    tileMode: TileMode.repeated,
  );
}

LinearGradient backgroundLinearColor() {
  return const LinearGradient(
    colors: [Color(0xffF4FDFF), Color(0xffD7E0FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.4, 0.7],
    tileMode: TileMode.repeated,
  );
}

class AppColors {
  AppColors._();
  static const Color kPrimaryColor = Color(0xFF11212E);
  static const Color kGreenColor = Color(0xff2E8B57);
  static const Color kLightBlue = Color(0xFF6DA7FF);
  static const Color kSecondaryColor = Color(0xFF0B2C47);
  static const Color kBackgroundColor = Colors.white;
  static const Color kFormLabelColor = kGreenColor;
  static const Color kLight = Color(0xffffffff);
  static const Color kGreyDk = Color(0xff9091AD);
  static const Color kAppBarColor = Color(0XFF0B2C47);
  static const Color kRewardBackgroundColor = Color(0xFF18122B);
  static const Color kButtonColor = Color(0xF1F1F1F1);
  static const Color keventCardColor = Color(0xFFF1F3FF);
  static const Color kchatBackgroundColor = Color(0xFFF1F3FF);

  static List<Color> colors = [
    const Color(0xff3765DD),
    const Color(0xff7464D2)
  ];
  static List<Color> winnerBackgroundColors = [
    const Color(0xff6C00FF),
    const Color(0xff7147E5),
  ];
}
