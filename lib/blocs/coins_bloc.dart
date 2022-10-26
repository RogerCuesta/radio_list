import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cripto_list/blocs/coins_event.dart';
import 'package:flutter_cripto_list/blocs/coins_state.dart';
import 'package:flutter_cripto_list/models/coin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinsBloc extends Bloc<CoinsEvent, CoinsState> {
  CoinsBloc() : super(CoinsState.initial()) {
    on<CoinsEvent>(
      _onCoinsEvent,
    );
  }

  FutureOr<void> _onCoinsEvent(
    CoinsEvent event,
    Emitter<CoinsState> emit,
  ) async {
    if (event is CoinsGetData) {
      await _getCoinsList(emit);
    } else if (event is CoinsSearch) {
      await _searchCoinByName(emit, event);
    }
  }

  Future<void> _searchCoinByName(
    Emitter<CoinsState> emit,
    CoinsSearch event,
  ) async {
    List<Coin> searchedCoinList;

    if (event.coinName.isEmpty) {
      emit(
        state.copyWith(
          coinsLoadStatus: CoinsLoadStatus.succeeded,
          coinsList: state.savedCoinList,
          savedCoinList: state.savedCoinList,
        ),
      );
    }
    searchedCoinList = state.coinsList
        .where((coin) =>
            coin.name!.toLowerCase().contains(event.coinName.toLowerCase()))
        .toList();

    emit(
      state.copyWith(
        coinsLoadStatus: CoinsLoadStatus.succeeded,
        coinsList: searchedCoinList,
        savedCoinList: state.savedCoinList,
      ),
    );
  }

  Future<void> _getCoinsList(
    Emitter<CoinsState> emit,
  ) async {
    emit(
      state.copyWith(
        coinsLoadStatus: CoinsLoadStatus.loading,
        coinsList: [],
        savedCoinList: [],
      ),
    );
    try {
      List<Coin> coins = [];
      var response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false'));
      if (response.statusCode == 200) {
        coins = (json.decode(response.body) as List)
            .map((data) => Coin.fromJson(data))
            .toList();
      }
      emit(
        state.copyWith(
          coinsLoadStatus: CoinsLoadStatus.succeeded,
          coinsList: coins,
          savedCoinList: coins,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          coinsLoadStatus: CoinsLoadStatus.failed,
          coinsList: [],
          savedCoinList: [],
        ),
      );
    }
  }
}
