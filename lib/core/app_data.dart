import 'package:finance_ui/core/app_icons.dart';
import 'package:finance_ui/core/models/activity_item.dart';
import 'package:finance_ui/core/models/portfolio_item.dart';

class AppData {
  static const userName = 'James';
  static const balance = '\$10.713.95';
  static const buyAvailable = '\$8.423';
  static const chartPrice = '\$ 123.22';
  static const chartDate = "Sept '22";

  static const portfolioItems = [
    PortfolioItem(
      id: 'aapl',
      name: 'Apple Inc.',
      ticker: '( AAPL )',
      amount: '\$7.213.05',
      gain: '+50.235 (5.25%)',
      image: AppIcons.cardImg1,
    ),
    PortfolioItem(
      id: 'msc',
      name: 'MasterCard',
      ticker: '( MSC )',
      amount: '\$2.789.00',
      gain: '+07.899 (2.25%)',
      image: AppIcons.cardImg2,
      isLight: true,
    ),
  ];

  static const activityItems = [
    ActivityItem(
      name: 'Netflix',
      ticker: '( NFLX )',
      amount: '\$4.123.50',
      gain: '+10.35%',
    ),
  ];

  static PortfolioItem portfolioById(String id) => portfolioItems.firstWhere(
    (item) => item.id == id,
    orElse: () => portfolioItems.first,
  );
}
