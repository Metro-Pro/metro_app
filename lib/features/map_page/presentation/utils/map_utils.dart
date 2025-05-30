import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:metro_app/models/station.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<bool> openInGoogleMaps(LatLng location) async {
    String url =
        "https://www.google.com/maps?q=${location.latitude},${location.longitude}";

    log('Opening Google Maps with URL: $url');
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      return false;
    }
    return true;
  }
}
