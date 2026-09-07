import 'dart:ui';

import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedBar extends StatefulWidget {
  final VoidCallback? onCompleted;
  final String label;
  final int arrowCount;
  final double trackHeight;
  final double thumbWidth;
  final double thumbHeight;
  final double arrowSize;
  final Color trackColor;

  const GetStartedBar({
    super.key,
    this.onCompleted,
    this.label = StringConst.getStarted,
    this.arrowCount = 5,
    this.trackHeight = 60,
    this.thumbWidth = 111,
    this.thumbHeight = 48,
    this.arrowSize = 20,
    this.trackColor = AppColors.surfaceElevatedColor,
  });

  @override
  State<GetStartedBar> createState() => _GetStartedBarState();
}

class _GetStartedBarState extends State<GetStartedBar> with TickerProviderStateMixin {
  static const _padding = 4.0;

  late final AnimationController _snapController;
  late final AnimationController _pulseController;

  double _dragOffset = 0;
  double _animStart = 0;
  double _animEnd = 0;
  bool _completed = false;
  bool _dragging = false;
  bool _reduceMotion = false;

  double _maxOffset(double width) => (width - widget.thumbWidth - (_padding * 2)).clamp(0, double.infinity);

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250))
      ..addListener(() => setState(() => _dragOffset = lerpDouble(_animStart, _animEnd, Curves.easeOutCubic.transform(_snapController.value))!));
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _reduceMotion = MediaQuery.disableAnimationsOf(context);
      if (_reduceMotion) return;
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _snapController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _animateTo(double target, {VoidCallback? onDone}) {
    if (_reduceMotion) {
      setState(() => _dragOffset = target);
      onDone?.call();
      return;
    }
    _animStart = _dragOffset;
    _animEnd = target;
    _snapController.duration = Duration(milliseconds: target > _dragOffset ? 200 : 250);
    _snapController.forward(from: 0).whenComplete(() {
      if (!mounted) return;
      onDone?.call();
    });
  }

  void _onDragStart() {
    if (_completed) return;
    _dragging = true;
    _snapController.stop();
    _pulseController.stop();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxOffset) {
    if (_completed) return;
    setState(() => _dragOffset = (_dragOffset + details.delta.dx).clamp(0, maxOffset));
  }

  void _onDragEnd(double maxOffset) {
    if (_completed) return;
    _dragging = false;
    if (_dragOffset >= maxOffset * 0.85) {
      _completed = true;
      _pulseController.stop();
      _animateTo(maxOffset, onDone: () => widget.onCompleted?.call());
      return;
    }
    _animateTo(0, onDone: () {
      if (!mounted || _completed || _reduceMotion) return;
      _pulseController.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxOffset = _maxOffset(constraints.maxWidth);
        final progress = maxOffset == 0 ? 0.0 : _dragOffset / maxOffset;
        return Container(
          width: double.infinity,
          height: widget.trackHeight,
          decoration: BoxDecoration(
            color: widget.trackColor,
            borderRadius: .circular(100),
          ),
          child: Stack(
            alignment: .center,
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  final pulse = _dragging || _completed || _reduceMotion ? 1.0 : 0.55 + (_pulseController.value * 0.45);
                  return Opacity(opacity: ((1 - progress) * pulse).clamp(0.15, 1), child: child,);
                },
                child: Padding(
                  padding: .only(right: 12),
                  child: Row(
                    spacing: widget.arrowSize == 20 ? 10 : 4,
                    mainAxisAlignment: .end,
                    children: List.generate(
                      widget.arrowCount,
                      (index) => Opacity(
                        opacity: 1 - (index * 0.15),
                        child: SvgPicture.asset(AppIcons.icArrowRight, width: widget.arrowSize, height: widget.arrowSize,),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _padding + _dragOffset,
                top: (widget.trackHeight - widget.thumbHeight) / 2,
                child: GestureDetector(
                  onHorizontalDragStart: (_) => _onDragStart(),
                  onHorizontalDragUpdate: (details) => _onDragUpdate(details, maxOffset),
                  onHorizontalDragEnd: (_) => _onDragEnd(maxOffset),
                  child: Container(
                    width: widget.thumbWidth,
                    height: widget.thumbHeight,
                    alignment: .center,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: .circular(24),
                    ),
                    child: Text(widget.label, style: AppTextStyles.button,),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
