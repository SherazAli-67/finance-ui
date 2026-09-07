import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/core/models/portfolio_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PortfolioCard extends StatelessWidget {
  final PortfolioItem item;
  final VoidCallback? onTap;

  const PortfolioCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: .circular(24),
        child: SizedBox(
          width: 254,
          height: 355,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(item.image, fit: .cover,),
              ),
              Positioned(
                left: 24,
                top: 30,
                child: Hero(
                  tag: 'portfolio-icon-${item.id}',
                  child: Container(
                    width: 61,
                    height: 61,
                    alignment: .center,
                    decoration: BoxDecoration(
                      color: item.isLight ? AppColors.iconDarkColor : AppColors.whiteColor.withValues(alpha: 0.5),
                      borderRadius: .circular(12),
                    ),
                    child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24, colorFilter: .mode(item.isLight ? AppColors.whiteColor : AppColors.iconDarkColor, .srcIn),),
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 30,
                child: Container(
                  width: double.infinity,
                  padding: .symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: item.isLight ? AppColors.glassDarkColor : AppColors.glassLightColor,
                    borderRadius: .circular(12),
                  ),
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: .start,
                    children: [
                      Text(item.amount, style: AppTextStyles.cardAmount,),
                      Text(item.gain, style: AppTextStyles.cardGain,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
