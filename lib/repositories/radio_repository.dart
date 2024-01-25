import 'package:flutter_radio/api/api_services.dart';
import 'package:flutter_radio/models/radio.dart' as radiomodel;

class RadioRepository {
  final RadioService radioService;

  RadioRepository({
    required this.radioService,
  });

  /// Get list of radios FM
  Future<List<radiomodel.Radio>> getRadios({
    required int limit,
    required int offset,
  }) async {
    return await radioService.getListOfRadiosFromSpain(
      limit: limit,
      offset: offset,
    );
  }

  /// Search radios
  Future<List<radiomodel.Radio>> searchRadios({
    required int limit,
    required int offset,
    String searchText = '',
  }) async {
    return await radioService.searchRadios(
      limit: limit,
      offset: offset,
      searchText: searchText,
    );
  }
}
