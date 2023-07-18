import 'package:flutter_radio/api/api_services.dart';
import 'package:flutter_radio/models/radio.dart' as radiomodel;

class RadioRepository {
  final RadioService radioService;

  RadioRepository({
    required this.radioService,
  });

  /// Get list of radios FM
  Future<List<radiomodel.Radio>> loadRadioFMList() async {
    return await radioService.getListOfRadiosFromSpain();
  }
}
