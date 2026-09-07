import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedBar extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final int arrowCount;

  const GetStartedBar({
    super.key,
    this.onTap,
    this.label = StringConst.getStarted,
    this.arrowCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: .only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevatedColor,
        borderRadius: .circular(100),
      ),
      child: Row(
        spacing: 30,
        children: [
          GradientButton(label: label, onTap: onTap,),
          Expanded(
            child: Row(
              spacing: 10,
              children: List.generate(
                arrowCount,
                (index) => Opacity(
                  opacity: 1 - (index * 0.15),
                  child: SvgPicture.asset(AppIcons.icArrowRight, width: 20, height: 20,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
