import 'dart:convert';
import 'dart:io';

import 'package:flutter_radio/models/radio.dart';
import 'package:http/http.dart' as http;

//Service that interact with Radio Browser API
class RadioService {
  Future<List<Radio>> getListOfRadiosFromSpain() async {
    final response = await http.get(
      Uri.parse(
          'https://at1.api.radio-browser.info/json/stations/bycountry/spain'),
    );

    if (response.statusCode != 200) {
      throw HttpException(
        response.body,
      );
    }

    final radios = (json.decode(response.body) as List)
        .map((data) => Radio.fromJson(data))
        .toList();
    return radios;
  }
}
