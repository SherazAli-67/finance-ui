import 'package:finance_ui/app_router/app_router.dart';
import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:finance_ui/presentation/widgets/get_started_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressFade;
  late final Animation<Offset> _progressSlide;
  late final Animation<double> _progressFill;
  late final Animation<double> _heroFade;
  late final Animation<double> _heroScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _subtitleFade;
  late final Animation<Offset> _subtitleSlide;
  late final Animation<double> _ctaFade;
  late final Animation<Offset> _ctaSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _progressFade = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.2, curve: Curves.easeOut));
    _progressSlide = Tween(begin: const Offset(0, -0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0, 0.2, curve: Curves.easeOut)));
    _progressFill = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.25, curve: Curves.easeOutCubic));
    _heroFade = CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.45, curve: Curves.easeOut));
    _heroScale = Tween(begin: 0.92, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.45, curve: Curves.easeOutCubic)));
    _titleFade = CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.6, curve: Curves.easeOut));
    _titleSlide = Tween(begin: const Offset(0, 0.15), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.35, 0.6, curve: Curves.easeOutCubic)));
    _subtitleFade = CurvedAnimation(parent: _controller, curve: const Interval(0.45, 0.7, curve: Curves.easeOut));
    _subtitleSlide = Tween(begin: const Offset(0, 0.12), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.45, 0.7, curve: Curves.easeOutCubic)));
    _ctaFade = CurvedAnimation(parent: _controller, curve: const Interval(0.55, 0.85, curve: Curves.easeOut));
    _ctaSlide = Tween(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.55, 0.85, curve: Curves.easeOutCubic)));
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
        child: Padding(
          padding: .all(24),
          child: Column(
            children: [
              FadeTransition(
                opacity: _progressFade,
                child: SlideTransition(
                  position: _progressSlide,
                  child: _WelcomeProgress(fill: _progressFill,),
                ),
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _heroFade,
                  child: ScaleTransition(
                    scale: _heroScale,
                    child: SizedBox.expand(child: Image.asset(AppIcons.welcomeHeaderImg, fit: .cover,),),
                  ),
                ),
              ),
              Column(
                spacing: 32,
                crossAxisAlignment: .start,
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: .start,
                    children: [
                      FadeTransition(
                        opacity: _titleFade,
                        child: SlideTransition(
                          position: _titleSlide,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: StringConst.welcomeTitlePrefix, style: AppTextStyles.hero,),
                                TextSpan(text: StringConst.welcomeTitleHighlight, style: AppTextStyles.heroBold,),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FadeTransition(
                        opacity: _subtitleFade,
                        child: SlideTransition(
                          position: _subtitleSlide,
                          child: Text(StringConst.welcomeSubtitle, style: AppTextStyles.body,),
                        ),
                      ),
                    ],
                  ),
                  FadeTransition(
                    opacity: _ctaFade,
                    child: SlideTransition(
                      position: _ctaSlide,
                      child: GetStartedBar(onCompleted: () => context.go(NamedRoutes.home.routeName),),
                    ),
                  ),
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
  final Animation<double> fill;

  const _WelcomeProgress({required this.fill});

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
              color: AppColors.surfaceElevatedColor,
              borderRadius: .circular(20),
            ),
            clipBehavior: .hardEdge,
            child: index == 0
                ? AnimatedBuilder(
                    animation: fill,
                    builder: (context, child) => Align(
                      alignment: .centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: fill.value,
                        child: child,
                      ),
                    ),
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.accentSoftColor,
                        borderRadius: .circular(20),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
