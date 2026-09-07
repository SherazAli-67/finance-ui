import 'package:finance_ui/app_router/app_router.dart';
import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .dark,
        fontFamily: 'Satoshi',
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: .dark(
          surface: AppColors.backgroundColor,
          primary: AppColors.accentColor,
          onPrimary: AppColors.whiteColor,
          secondary: AppColors.accentSoftColor,
        ),
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
