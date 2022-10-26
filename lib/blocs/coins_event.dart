import 'package:equatable/equatable.dart';

abstract class CoinsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CoinsGetData extends CoinsEvent {}

class CoinsSearch extends CoinsEvent {
  final String coinName;

  CoinsSearch({
    required this.coinName,
  });
  @override
  List<Object> get props => [
        coinName,
      ];
}
