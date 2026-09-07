import 'package:finance_ui/constants/string_const.dart';
import 'package:finance_ui/core/app_colors.dart';
import 'package:finance_ui/core/app_textstyles.dart';
import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final String amount;
  final VoidCallback? onAdd;

  const BalanceCard({
    super.key,
    required this.amount,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: .symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: .circular(20),
      ),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Column(
              spacing: 14,
              crossAxisAlignment: .start,
              children: [
                Text(StringConst.yourBalance, style: AppTextStyles.label,),
                Text(amount, style: AppTextStyles.balanceAmount,),
              ],
            ),
          ),
          GestureDetector(
            onTap: onAdd,
            child: Container(
              padding: .all(2),
              decoration: BoxDecoration(
                color: AppColors.accentTintColor,
                borderRadius: .circular(6),
                border: .all(color: AppColors.accentColor),
              ),
              child: Icon(Icons.add, size: 19, color: AppColors.accentColor,),
            ),
          ),
        ],
      ),
    );
  }
}
