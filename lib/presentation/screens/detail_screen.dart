import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_data.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/core/models/portfolio_item.dart';
import 'package:finance_ui/presentation/widgets/circle_icon_button.dart';
import 'package:finance_ui/presentation/widgets/get_started_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final item = AppData.portfolioById(id);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: .symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  CircleIconButton(icon: AppIcons.icArrowRight, flipX: true, onTap: () => context.pop(),),
                  const Spacer(),
                  CircleIconButton(icon: AppIcons.icMenu,),
                ],
              ),
            ),
            _AssetHeader(item: item,),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: .fromLTRB(24, 32, 24, 0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: .vertical(top: .circular(40)),
                ),
                child: Column(
                  spacing: 24,
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: .symmetric(horizontal: 17, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceMutedColor,
                        borderRadius: .circular(10),
                      ),
                      child: Row(
                        spacing: 6,
                        mainAxisSize: .min,
                        children: [
                          Text(StringConst.weekly, style: AppTextStyles.chip,),
                          Icon(Icons.keyboard_arrow_down, size: 16, color: AppColors.textPrimaryColor,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Image.asset(AppIcons.weeklyGraph, fit: .contain,),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: .fromLTRB(24, 32, 24, 24),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevatedColor,
                borderRadius: .vertical(top: .circular(40)),
              ),
              child: Row(
                spacing: 16,
                crossAxisAlignment: .end,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: .start,
                      children: [
                        Text(StringConst.availableForBuying, style: AppTextStyles.label,),
                        Text(AppData.buyAvailable, style: AppTextStyles.buyAmount,),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 148,
                    child: GetStartedBar(
                      label: StringConst.buy,
                      arrowCount: 3,
                      trackHeight: 49,
                      thumbWidth: 62,
                      thumbHeight: 41,
                      arrowSize: 16,
                      trackColor: AppColors.surfaceColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetHeader extends StatelessWidget {
  final PortfolioItem item;

  const _AssetHeader({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Container(
          width: 61,
          height: 61,
          alignment: .center,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: .circular(14),
          ),
          child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
        Column(
          spacing: 4,
          children: [
            Text(item.name, style: AppTextStyles.detailTitle,),
            Text(item.ticker, style: AppTextStyles.detailTicker,),
          ],
        ),
      ],
    );
  }
}
