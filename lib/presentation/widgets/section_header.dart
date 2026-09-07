import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.sectionTitle,),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAll,
          child: Text(StringConst.seeAll, style: AppTextStyles.seeAll,),
        ),
      ],
    );
  }
}
