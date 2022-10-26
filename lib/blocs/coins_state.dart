import 'package:flutter_cripto_list/models/coin.dart';

enum CoinsLoadStatus {
  loading,
  succeeded,
  failed,
}

class CoinsState {
  final CoinsLoadStatus coinsLoadStatus;
  final List<Coin> coinsList;
  final List<Coin> savedCoinList;

  CoinsState({
    required this.coinsList,
    required this.coinsLoadStatus,
    required this.savedCoinList,
  });

  factory CoinsState.initial() => CoinsState(
        coinsList: [],
        coinsLoadStatus: CoinsLoadStatus.loading,
        savedCoinList: [],
      );

  CoinsState copyWith({
    required CoinsLoadStatus coinsLoadStatus,
    required List<Coin> coinsList,
    required List<Coin> savedCoinList,
  }) =>
      CoinsState(
        coinsList: coinsList,
        coinsLoadStatus: coinsLoadStatus,
        savedCoinList: savedCoinList,
      );
}
