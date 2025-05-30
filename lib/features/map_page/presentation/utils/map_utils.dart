import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:metro_app/models/station.dart';

class MapUtils {
  static Future<List<Station>> getStations() async {
    final stationsJson = jsonDecode(
        await rootBundle.loadString('assets/json/metro_stations.json')) as List;
    return stationsJson
        .map((station) => Station.fromMap(station as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Station>> getStationsByLine(String lineNumber) async {
    final stations = await getStations();
    return stations
        .where((station) => station.lineNumber == lineNumber)
        .toList();
  }
}
