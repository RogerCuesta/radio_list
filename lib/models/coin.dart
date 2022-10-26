import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
  });

  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final int? marketCap;
  final int? marketCapRank;

  factory Coin.fromJson(Map<String, dynamic> json) {
    final currentPrice = json["current_price"] as num?;
    final marketCap = json["market_cap"] as num?;
    final marketCapRank = json["market_cap_rank"] as num?;
    return Coin(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      image: json["image"],
      currentPrice: currentPrice?.toDouble(),
      marketCap: marketCap?.toInt(),
      marketCapRank: marketCapRank?.toInt(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        symbol,
        name,
        image,
        currentPrice,
        marketCap,
        marketCapRank,
      ];
}
