import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/features/home/bloc/home_state.dart';
import 'package:flutter_radio/repositories/radio_repository.dart';

class HomeCubit extends Cubit<HomeState> {
  final ScrollController _scrollController = ScrollController();
  final RadioRepository radioRepository;
  final int itemsPage = 20;
  int currentPage = 0;
  String _searchText = '';

  HomeCubit({required this.radioRepository}) : super(HomeState.initial());

  ScrollController get scrollController => _scrollController;

  void _resetPagination() {
    currentPage = 0;
  }

  Future<void> loadRadioChannels(
      {String searchText = '', bool resetPagination = false}) async {
    emit(state.copyWith(
        status: RadiosLoadStatus.loading, radioChannels: [], errorStatus: ''));
    try {
      _searchText = searchText;
      if (resetPagination) {
        _resetPagination();
      }
      final result = _searchText.isEmpty
          ? await radioRepository.getRadios(
              limit: itemsPage,
              offset: currentPage * itemsPage,
            )
          : await radioRepository.searchRadios(
              limit: itemsPage,
              offset: currentPage * itemsPage,
              searchText: _searchText,
            );
      currentPage++;
      emit(state.copyWith(
          status: RadiosLoadStatus.succeeded,
          radioChannels: result,
          errorStatus: ''));
    } catch (error) {
      _resetPagination();
      emit(state.copyWith(
          status: RadiosLoadStatus.failed,
          radioChannels: [],
          errorStatus: '$error'));
    }
  }

  Future<void> loadMoreRadioChannels() async {
    if (state.status != RadiosLoadStatus.loading) {
      emit(state.copyWith(loadingMore: true));
      try {
        final result = await radioRepository.getRadios(
          limit: itemsPage,
          offset: currentPage * itemsPage,
          //searchText: _searchText,
        );
        if (result.isEmpty) {
          emit(state.copyWith(loadingMore: false));
        } else {
          currentPage++;
          emit(state.copyWith(
            radioChannels: [...state.radioChannels, ...result],
            loadingMore: true,
          ));
        }
      } catch (error) {
        _resetPagination();
        emit(state.copyWith(
            status: RadiosLoadStatus.failed,
            radioChannels: [],
            errorStatus: '$error',
            loadingMore: false));
      }
    }
  }

  @override
  Future<void> close() {
    _scrollController.dispose();
    return super.close();
  }
}
