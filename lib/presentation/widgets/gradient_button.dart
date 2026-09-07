import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  const GradientButton({
    super.key,
    required this.label,
    this.onTap,
    this.padding = const .symmetric(horizontal: 19, vertical: 11),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          gradient: AppColors.accentGradient,
          borderRadius: .circular(24),
        ),
        child: Text(label, style: AppTextStyles.button,),
      ),
    );
  }
}
