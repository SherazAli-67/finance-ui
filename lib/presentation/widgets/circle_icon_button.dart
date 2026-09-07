import 'package:finance_ui/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final double size;
  final double iconSize;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.size = 50,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: .center,
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          shape: .circle,
        ),
        child: SvgPicture.asset(icon, width: iconSize, height: iconSize, colorFilter: .mode(iconColor ?? AppColors.textPrimaryColor, .srcIn),),
      ),
    );
  }
}
