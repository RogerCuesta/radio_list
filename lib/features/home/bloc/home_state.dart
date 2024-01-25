import 'package:equatable/equatable.dart';
import 'package:flutter_radio/models/radio.dart';

class HomeState extends Equatable {
  final List<Radio> radioChannels;
  final RadiosLoadStatus status;
  final String errorStatus;
  final bool loadingMore;

  const HomeState({
    required this.radioChannels,
    required this.status,
    required this.errorStatus,
    this.loadingMore = false,
  });

  // Factory constructor for the initial state
  factory HomeState.initial() => const HomeState(
        radioChannels: [],
        status: RadiosLoadStatus.loading,
        errorStatus: '',
        loadingMore: false,
      );

  // CopyWith method for creating a new state with updated values
  HomeState copyWith({
    List<Radio>? radioChannels,
    RadiosLoadStatus? status,
    String? errorStatus,
    bool? loadingMore,
  }) {
    return HomeState(
      radioChannels: radioChannels ?? this.radioChannels,
      status: status ?? this.status,
      errorStatus: errorStatus ?? this.errorStatus,
      loadingMore: loadingMore ?? this.loadingMore,
    );
  }

  @override
  List<Object?> get props => [radioChannels, status, errorStatus, loadingMore];
}

enum RadiosLoadStatus {
  loading,
  succeeded,
  failed,
}