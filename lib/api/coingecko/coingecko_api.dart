import 'dart:convert';
import 'dart:io';

import 'package:flutter_cripto_list/models/coin.dart';
import 'package:http/http.dart' as http;

//Service that interact with Coingecko API
class CoingeckoService {
  Future<List<Coin>> getListOfCoins() async {
    final response = await http.get(
      Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'),
    );

    if (response.statusCode != 200) {
      throw HttpException(
        response.body,
      );
    }
    
    final coins = (json.decode(response.body) as List)
        .map((data) => Coin.fromJson(data))
        .toList();
    return coins;
  }
}
