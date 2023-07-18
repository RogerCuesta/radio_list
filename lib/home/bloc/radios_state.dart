import 'package:flutter_radio/models/radio.dart';

enum RadiosLoadStatus {
  loading,
  succeeded,
  failed,
}

class RadiosState {
  final RadiosLoadStatus radiosLoadStatus;
  final List<Radio> radioList;
  final List<Radio> savedRadioList;

  RadiosState({
    required this.radioList,
    required this.radiosLoadStatus,
    required this.savedRadioList,
  });

  factory RadiosState.initial() => RadiosState(
        radioList: [],
        radiosLoadStatus: RadiosLoadStatus.loading,
        savedRadioList: [],
      );

  RadiosState copyWith({
    required RadiosLoadStatus radiosLoadStatus,
    required List<Radio> radioList,
    required List<Radio> savedRadioList,
  }) =>
      RadiosState(
        radioList: radioList,
        radiosLoadStatus: radiosLoadStatus,
        savedRadioList: savedRadioList,
      );
}
