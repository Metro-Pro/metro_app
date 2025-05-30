import 'package:flutter/foundation.dart';

class MetroLine {
  final String id;
  final String name;
  final String code;
  final String color;
  final List<String> stationIds;
  final bool isActive;
  final String? description;
  final Map<String, dynamic>?
      schedule; // e.g., {'weekday': {...}, 'weekend': {...}}
  final int? frequency; // minutes between trains
  final String? status; // 'normal', 'delayed', 'maintenance'

  MetroLine({
    required this.id,
    required this.name,
    required this.code,
    required this.color,
    required this.stationIds,
    required this.isActive,
    this.description,
    this.schedule,
    this.frequency,
    this.status,
  });

  static MetroLine fromJson(Map<String, dynamic> json) {
    return MetroLine(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      color: json['color'],
      stationIds: List<String>.from(json['stationIds']),
      isActive: json['isActive'],
      description: json['description'],
      schedule: json['schedule'],
      frequency: json['frequency'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'color': color,
      'stationIds': stationIds,
      'isActive': isActive,
      'description': description,
      'schedule': schedule,
      'frequency': frequency,
      'status': status,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MetroLine &&
        other.id == id &&
        other.name == name &&
        other.code == code &&
        other.color == color &&
        listEquals(other.stationIds, stationIds) &&
        other.isActive == isActive &&
        other.description == description &&
        mapEquals(other.schedule, schedule) &&
        other.frequency == frequency &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        code.hashCode ^
        color.hashCode ^
        stationIds.hashCode ^
        isActive.hashCode ^
        description.hashCode ^
        schedule.hashCode ^
        frequency.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'MetroLine(id: $id, name: $name, code: $code, isActive: $isActive)';
  }
}
