import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cripto_list/home/bloc/coins_event.dart';
import 'package:flutter_cripto_list/home/bloc/coins_state.dart';
import 'package:flutter_cripto_list/models/coin.dart';
import 'package:flutter_cripto_list/repositories/coingecko_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinsBloc extends Bloc<CoinsEvent, CoinsState> {
  final CoingeckoRepository _coingeckoRepository;
  CoinsBloc({
    required CoingeckoRepository coingeckoRepository,
  })  : _coingeckoRepository = coingeckoRepository,
        super(CoinsState.initial()) {
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
      var coins = await _coingeckoRepository.loadFavoriteCoffees();
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
