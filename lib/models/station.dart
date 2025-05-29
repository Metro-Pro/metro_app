import 'package:flutter/foundation.dart';

class Station {
  final String id;
  final String name;
  final String code;
  final double latitude;
  final double longitude;
  final List<String> lineIds;
  final bool isActive;
  final String? address;
  final String? description;
  final Map<String, dynamic>?
      facilities; // e.g., {'parking': true, 'wheelchair': true}
  final List<String>? connectingStations;

  Station({
    required this.id,
    required this.name,
    required this.code,
    required this.latitude,
    required this.longitude,
    required this.lineIds,
    required this.isActive,
    this.address,
    this.description,
    this.facilities,
    this.connectingStations,
  });

  static Station fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      lineIds: List<String>.from(json['lineIds']),
      isActive: json['isActive'],
      address: json['address'],
      description: json['description'],
      facilities: json['facilities'],
      connectingStations: json['connectingStations'] != null
          ? List<String>.from(json['connectingStations'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'latitude': latitude,
      'longitude': longitude,
      'lineIds': lineIds,
      'isActive': isActive,
      'address': address,
      'description': description,
      'facilities': facilities,
      'connectingStations': connectingStations,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Station &&
        other.id == id &&
        other.name == name &&
        other.code == code &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.lineIds, lineIds) &&
        other.isActive == isActive &&
        other.address == address &&
        other.description == description &&
        mapEquals(other.facilities, facilities) &&
        listEquals(other.connectingStations, connectingStations);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        lineIds.hashCode ^
        isActive.hashCode ^
        address.hashCode ^
        description.hashCode ^
        facilities.hashCode ^
        connectingStations.hashCode;
  }

  @override
  String toString() {
    return 'Station(id: $id, name: $name, code: $code, isActive: $isActive)';
  }
}
