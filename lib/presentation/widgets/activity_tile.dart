import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/core/models/activity_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActivityTile extends StatelessWidget {
  final ActivityItem item;
  final VoidCallback? onTap;

  const ActivityTile({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: .symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: .circular(14),
        ),
        child: Row(
          spacing: 25,
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: .center,
              decoration: BoxDecoration(
                color: AppColors.iconDarkColor,
                borderRadius: .circular(12),
              ),
              child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24, colorFilter: .mode(AppColors.textMutedColor, .srcIn),),
            ),
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: .start,
                children: [
                  Text(item.name, style: AppTextStyles.activityTitle,),
                  Text(item.ticker, style: AppTextStyles.activityTicker,),
                ],
              ),
            ),
            Column(
              spacing: 7,
              crossAxisAlignment: .end,
              children: [
                Text(item.amount, style: AppTextStyles.activityAmount,),
                Text(item.gain, style: AppTextStyles.activityGain,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
