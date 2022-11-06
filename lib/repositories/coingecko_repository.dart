import 'package:flutter/material.dart';
import 'package:flutter_cripto_list/api/api_services.dart';
import 'package:flutter_cripto_list/models/coin.dart';

class CoingeckoRepository {
  final CoingeckoService coingeckoService;

  CoingeckoRepository({
    required this.coingeckoService,
  });

  /// Get list of coins
  Future<List<Coin>> loadFavoriteCoffees() async {
    return await coingeckoService.getListOfCoins();
  }
}
