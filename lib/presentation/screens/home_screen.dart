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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _balanceFade;
  late final Animation<Offset> _balanceSlide;
  late final Animation<double> _portfolioHeaderFade;
  late final Animation<Offset> _portfolioHeaderSlide;
  late final List<Animation<double>> _cardFades;
  late final List<Animation<Offset>> _cardSlides;
  late final Animation<double> _activityFade;
  late final Animation<Offset> _activitySlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 850));
    _headerFade = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.2, curve: Curves.easeOut));
    _headerSlide = Tween(begin: const Offset(0, -0.15), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0, 0.2, curve: Curves.easeOut)));
    _balanceFade = CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.4, curve: Curves.easeOut));
    _balanceSlide = Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.4, curve: Curves.easeOutCubic)));
    _portfolioHeaderFade = CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.55, curve: Curves.easeOut));
    _portfolioHeaderSlide = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.55, curve: Curves.easeOutCubic)));
    _cardFades = List.generate(AppData.portfolioItems.length, (index) {
      final begin = (0.45 + index * 0.08).clamp(0.0, 0.7);
      final end = (begin + 0.25).clamp(0.0, 0.95);
      return CurvedAnimation(parent: _controller, curve: Interval(begin, end, curve: Curves.easeOut));
    });
    _cardSlides = List.generate(AppData.portfolioItems.length, (index) {
      final begin = (0.45 + index * 0.08).clamp(0.0, 0.7);
      final end = (begin + 0.25).clamp(0.0, 0.95);
      return Tween(begin: const Offset(0.15, 0), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Interval(begin, end, curve: Curves.easeOutCubic)));
    });
    _activityFade = CurvedAnimation(parent: _controller, curve: const Interval(0.65, 0.9, curve: Curves.easeOut));
    _activitySlide = Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.65, 0.9, curve: Curves.easeOutCubic)));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1;
        return;
      }
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              //headerWidget
              _buildHomeHeaderWidget(),
              //balanceCard widget
              _buildBalanceCardWidget(),
              Column(
                spacing: 24,
                crossAxisAlignment: .start,
                children: [
                  //portfolio header txt
                  _buildPortfolioHeaderTxtWidget(),
                  SizedBox(
                    height: 355,
                    child: ListView.separated(
                      scrollDirection: .horizontal,
                      itemCount: AppData.portfolioItems.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 30),
                      itemBuilder: (context, index) => FadeTransition(
                        opacity: _cardFades[index],
                        //portfolio card item widget
                        child: _buildPortfolioCardItemWidget(index, context)
                      ),
                    ),
                  ),
                ],
              ),
              //activity section
              _buildActivitySectionWidget()
            ],
          ),
        ),
      ),
    );
  }

  SlideTransition _buildPortfolioCardItemWidget(int index, BuildContext context) {
    return SlideTransition(
        position: _cardSlides[index],
        child: PortfolioCard(
          item: AppData.portfolioItems[index],
          onTap: () => context.push('${NamedRoutes.detail.routeName}/${AppData.portfolioItems[index].id}'),
        )
    );
  }

  FadeTransition _buildActivitySectionWidget() {
    return FadeTransition(
              opacity: _activityFade,
              child: SlideTransition(
                position: _activitySlide,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: .start,
                  children: [
                    SectionHeader(title: StringConst.activity,),
                    ...AppData.activityItems.map((item) => ActivityTile(item: item,)),
                  ],
                ),
              ),
            );
  }

  FadeTransition _buildPortfolioHeaderTxtWidget() {
    return FadeTransition(
                  opacity: _portfolioHeaderFade,
                  child: SlideTransition(position: _portfolioHeaderSlide, child: SectionHeader(title: StringConst.yourPortfolio,),),
                );
  }

  FadeTransition _buildBalanceCardWidget() {
    return FadeTransition(
              opacity: _balanceFade,
              child: SlideTransition(position: _balanceSlide, child: BalanceCard(amount: AppData.balance,),),
            );
  }

  FadeTransition _buildHomeHeaderWidget() {
    return FadeTransition(
              opacity: _headerFade,
              child: SlideTransition(position: _headerSlide, child: const _HomeHeader(),),
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
                color: AppColors.accentColor,
              ),
              child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24,),
            ),
          ],
        ),
      ],
    );
  }
}
