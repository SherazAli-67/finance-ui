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

class _GetStartedBarState extends State<GetStartedBar> {
  static const _padding = 4.0;

  double _dragOffset = 0;
  bool _completed = false;

  double _maxOffset(double width) => (width - widget.thumbWidth - (_padding * 2)).clamp(0, double.infinity);

  void _onDragUpdate(DragUpdateDetails details, double maxOffset) {
    if (_completed) return;
    setState(() => _dragOffset = (_dragOffset + details.delta.dx).clamp(0, maxOffset));
  }

  void _onDragEnd(double maxOffset) {
    if (_completed) return;
    if (_dragOffset >= maxOffset * 0.85) {
      setState(() {
        _dragOffset = maxOffset;
        _completed = true;
      });
      widget.onCompleted?.call();
      return;
    }
    setState(() => _dragOffset = 0);
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
              Opacity(
                opacity: (1 - progress).clamp(0.15, 1),
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
