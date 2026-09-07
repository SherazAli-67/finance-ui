import 'package:finance_ui/core/models/portfolio_item.dart';
import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget {
  final PortfolioItem item;
  final VoidCallback? onTap;

  const PortfolioCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: .circular(24),
        child: Image.asset(item.image, width: 254, height: 355, fit: .cover,),
      ),
    );
  }
}
