import 'dart:convert';
import 'dart:io';

import 'package:flutter_radio/models/radio.dart';
import 'package:http/http.dart' as http;

//Service that interact with Radio Browser API
class RadioService {
  final String baseUrl = "https://at1.api.radio-browser.info/json/stations";

  Future<List<Radio>> getListOfRadiosFromSpain({
    required int limit,
    required int offset,
  }) async {
    final queryParams = {
      'countrycode': 'ES',
      'limit': limit.toString(),
      'offset': offset.toString(),
      'order': 'name',
    };

    final uri =
        Uri.parse("$baseUrl/search").replace(queryParameters: queryParams);

    final response = await http.get(uri);

    //print('URL -> $baseUrl -> parameters: $queryParams');

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

  Future<List<Radio>> searchRadios({
    required int limit,
    required int offset,
    String searchText = '',
  }) async {
    final queryParams = {
      'countrycode': 'ES',
      'limit': limit.toString(),
      'offset': offset.toString(),
      'order': 'name',
      'name': searchText,
    };
    final uri =
        Uri.parse("$baseUrl/search").replace(queryParameters: queryParams);

    final response = await http.get(uri);
    //print('URL -> $baseUrl -> parameters: $queryParams');

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
