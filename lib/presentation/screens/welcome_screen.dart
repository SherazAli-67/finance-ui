import 'package:finance_ui/app_router/app_router.dart';
import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/presentation/widgets/get_started_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: .all(24),
          child: Column(
            children: [
              const _WelcomeProgress(),
              Expanded(child: SizedBox.expand(child: Image.asset(AppIcons.welcomeHeaderImg, fit: .cover,),)),
              Column(
                crossAxisAlignment: .start,
                spacing: 32,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: .start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: StringConst.welcomeTitlePrefix, style: AppTextStyles.hero,),
                            TextSpan(text: StringConst.welcomeTitleHighlight, style: AppTextStyles.heroBold,),
                          ],
                        ),
                      ),
                      Text(StringConst.welcomeSubtitle, style: AppTextStyles.body,),
                    ],
                  ),
                  GetStartedBar(onCompleted: () => context.go(NamedRoutes.home.routeName),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WelcomeProgress extends StatelessWidget {
  const _WelcomeProgress();

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 24,
      children: List.generate(
        3,
        (index) => Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: index == 0 ? AppColors.accentSoftColor : AppColors.surfaceElevatedColor,
              borderRadius: .circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
