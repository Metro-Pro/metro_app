// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:latlong2/latlong.dart';

class Station {
  final String id;
  final String name;
  final LatLng location;
  final String lineNumber;
  final String googleMapsLink;

  Station({
    required this.id,
    required this.name,
    required this.location,
    required this.lineNumber,
    required this.googleMapsLink,
  });

  @override
  String toString() {
    return 'Station(id: $id, name: $name, location: $location, lineNumber: $lineNumber, googleMapsLink: $googleMapsLink)';
  }

  Station copyWith({
    String? id,
    String? name,
    LatLng? location,
    String? lineNumber,
    String? googleMapsLink,
  }) {
    return Station(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      lineNumber: lineNumber ?? this.lineNumber,
      googleMapsLink: googleMapsLink ?? this.googleMapsLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude
      },
      'lineNumber': lineNumber,
      'googleMapsLink': googleMapsLink,
    };
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'].toString(),
      name: map['station_name'] as String,
      location: LatLng(
        map['latitude'] as double,
        map['longitude'] as double,
      ),
      lineNumber: map['line_number'].toString(),
      googleMapsLink: map['google_maps_link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Station.fromJson(String source) =>
      Station.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant Station other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.location == location &&
        other.lineNumber == lineNumber &&
        other.googleMapsLink == googleMapsLink;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        location.hashCode ^
        lineNumber.hashCode ^
        googleMapsLink.hashCode;
  }
}
