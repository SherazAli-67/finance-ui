import 'package:flutter/material.dart';

class AppColors {
  static const backgroundColor = Color(0xFF1F1F1F);
  static const surfaceColor = Color(0xFF262626);
  static const surfaceElevatedColor = Color(0xFF303030);
  static const surfaceMutedColor = Color(0xFF333333);
  static const iconDarkColor = Color(0xFF383838);
  static const textPrimaryColor = Color(0xFFFAFAFA);
  static const textMutedColor = Color(0xFF9B9B9B);
  static const accentColor = Color(0xFFFF7955);
  static const accentSoftColor = Color(0xFFFFCEB5);
  static const accentLightColor = Color(0xFFFFE7DB);
  static const accentPeachColor = Color(0xFFFFCAAD);
  static const accentMidColor = Color(0xFFFF9255);
  static const accentDeepColor = Color(0xFFFF6E47);
  static const cardLabelColor = Color(0xFFFFDDCC);
  static const gainColor = Color(0xFF25CAAC);
  static const whiteColor = Color(0xFFFFFFFF);
  static const transparentColor = Color(0x00000000);
  static const glassLightColor = Color(0x1FFFFFFF);
  static const glassDarkColor = Color(0x1A1F1F1F);
  static const accentTintColor = Color(0x1FFF7955);

  static const accentGradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [
      accentMidColor,
      Color(0xFFFF9055),
      accentDeepColor,
    ],
    stops: [0.25, 0.35, 0.97],
  );

  static const peachGradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [
      whiteColor,
      accentPeachColor,
      accentColor,
    ],
    stops: [0.15, 0.64, 1.0],
  );

  static const fadeToBackgroundGradient = LinearGradient(
    begin: .topCenter,
    end: .bottomCenter,
    colors: [
      transparentColor,
      backgroundColor,
    ],
  );
}
