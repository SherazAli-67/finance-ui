class PortfolioItem {
  final String id;
  final String name;
  final String ticker;
  final String amount;
  final String gain;
  final String image;
  final bool isLight;

  const PortfolioItem({
    required this.id,
    required this.name,
    required this.ticker,
    required this.amount,
    required this.gain,
    required this.image,
    this.isLight = false,
  });
}
