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

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _topBarFade;
  late final Animation<double> _headerFade;
  late final Animation<double> _headerScale;
  late final Animation<double> _sheetFade;
  late final Animation<Offset> _sheetSlide;
  late final Animation<double> _chipFade;
  late final Animation<double> _graphFade;
  late final Animation<double> _buyFade;
  late final Animation<Offset> _buySlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 850));
    _topBarFade = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.2, curve: Curves.easeOut));
    _headerFade = CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.4, curve: Curves.easeOut));
    _headerScale = Tween(begin: 0.9, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.4, curve: Curves.easeOutCubic)));
    _sheetFade = CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.65, curve: Curves.easeOut));
    _sheetSlide = Tween(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.65, curve: Curves.easeOutCubic)));
    _chipFade = CurvedAnimation(parent: _controller, curve: const Interval(0.45, 0.65, curve: Curves.easeOut));
    _graphFade = CurvedAnimation(parent: _controller, curve: const Interval(0.55, 0.75, curve: Curves.easeOut));
    _buyFade = CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.easeOut));
    _buySlide = Tween(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.easeOutCubic)));
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
    final item = AppData.portfolioById(widget.id);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            FadeTransition(
              opacity: _topBarFade,
              child: Padding(
                padding: .symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    CircleIconButton(icon: AppIcons.icArrowRight, flipX: true, onTap: () => context.pop(),),
                    const Spacer(),
                    CircleIconButton(icon: AppIcons.icMenu,),
                  ],
                ),
              ),
            ),
            FadeTransition(
              opacity: _headerFade,
              child: ScaleTransition(scale: _headerScale, child: _AssetHeader(item: item,),),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FadeTransition(
                opacity: _sheetFade,
                child: SlideTransition(
                  position: _sheetSlide,
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
                        FadeTransition(
                          opacity: _chipFade,
                          child: Container(
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
                        ),
                        Expanded(
                          child: FadeTransition(
                            opacity: _graphFade,
                            child: Center(child: Image.asset(AppIcons.weeklyGraph, fit: .contain,),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _buyFade,
              child: SlideTransition(
                position: _buySlide,
                child: Container(
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
        Hero(
          tag: 'portfolio-icon-${item.id}',
          child: Container(
            width: 61,
            height: 61,
            alignment: .center,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              borderRadius: .circular(14),
            ),
            child: SvgPicture.asset(AppIcons.icGallery, width: 24, height: 24,),
          ),
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
