import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/home/bloc/radios_event.dart';
import 'package:flutter_radio/home/bloc/radios_state.dart';
import 'package:flutter_radio/repositories/radio_repository.dart';


class RadiosBloc extends Bloc<RadiosEvent, RadiosState> {
  final RadioRepository _radioRepository;
  RadiosBloc({
    required RadioRepository radioRepository,
  })  : _radioRepository = radioRepository,
        super(RadiosState.initial()) {
    on<RadiosEvent>(
      _onRadiosEvent,
    );
  }

  FutureOr<void> _onRadiosEvent(
    RadiosEvent event,
    Emitter<RadiosState> emit,
  ) async {
    if (event is RadiosGetData) {
      await _getRadioList(emit);
    }
  }

  Future<void> _getRadioList(
    Emitter<RadiosState> emit,
  ) async {
    emit(
      state.copyWith(
        radiosLoadStatus: RadiosLoadStatus.loading,
        radioList: [],
        savedRadioList: [],
      ),
    );
    try {
      var radios = await _radioRepository.loadRadioFMList();
      emit(
        state.copyWith(
          radiosLoadStatus: RadiosLoadStatus.succeeded,
          radioList: radios,
          savedRadioList: radios,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          radiosLoadStatus: RadiosLoadStatus.failed,
          radioList: [],
          savedRadioList: [],
        ),
      );
    }
  }
}
