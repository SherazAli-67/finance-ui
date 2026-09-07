import 'package:finance_ui/app_router/app_router.dart';
import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_data.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/presentation/widgets/activity_tile.dart';
import 'package:finance_ui/presentation/widgets/balance_card.dart';
import 'package:finance_ui/presentation/widgets/portfolio_card.dart';
import 'package:finance_ui/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .symmetric(horizontal: 24, vertical: 16),
          child: Column(
            spacing: 35,
            crossAxisAlignment: .start,
            children: [
              const _HomeHeader(),
              BalanceCard(amount: AppData.balance,),
              Column(
                spacing: 24,
                crossAxisAlignment: .start,
                children: [
                  SectionHeader(title: StringConst.yourPortfolio,),
                  SizedBox(
                    height: 355,
                    child: ListView.separated(
                      scrollDirection: .horizontal,
                      itemCount: AppData.portfolioItems.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 30),
                      itemBuilder: (context, index) => PortfolioCard(
                        item: AppData.portfolioItems[index],
                        onTap: () => context.push('${NamedRoutes.detail.routeName}/${AppData.portfolioItems[index].id}'),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 16,
                crossAxisAlignment: .start,
                children: [
                  SectionHeader(title: StringConst.activity,),
                  ...AppData.activityItems.map((item) => ActivityTile(item: item,)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: StringConst.hello, style: AppTextStyles.greeting,),
                TextSpan(text: ' ${AppData.userName}!', style: AppTextStyles.greetingBold,),
              ],
            ),
          ),
        ),
        Row(
          spacing: 20,
          children: [
            SvgPicture.asset(AppIcons.icNotifications, width: 26, height: 26,),
            Container(
              width: 50,
              height: 50,
              alignment: .center,
              decoration: BoxDecoration(
                shape: .circle,
                color: AppColors.accentColor
              ),
              child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24),
            ),
          ],
        ),
      ],
    );
  }
}
