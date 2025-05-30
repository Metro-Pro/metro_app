class ScanLog {
  final String id;
  final String ticketId;
  final String stationId;
  final String userId;
  final DateTime scanTime;
  final String scanType; // 'entry' or 'exit'
  final String status; // 'success' or 'failed'

  ScanLog({
    required this.id,
    required this.ticketId,
    required this.stationId,
    required this.userId,
    required this.scanTime,
    required this.scanType,
    required this.status,
  });

  static ScanLog fromJson(Map<String, dynamic> json) {
    return ScanLog(
      id: json['id'],
      ticketId: json['ticketId'],
      stationId: json['stationId'],
      userId: json['userId'],
      scanTime: DateTime.parse(json['scanTime']),
      scanType: json['scanType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticketId': ticketId,
      'stationId': stationId,
      'userId': userId,
      'scanTime': scanTime.toIso8601String(),
      'scanType': scanType,
      'status': status,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScanLog &&
        other.id == id &&
        other.ticketId == ticketId &&
        other.stationId == stationId &&
        other.userId == userId &&
        other.scanTime == scanTime &&
        other.scanType == scanType &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ticketId.hashCode ^
        stationId.hashCode ^
        userId.hashCode ^
        scanTime.hashCode ^
        scanType.hashCode ^
        status.hashCode;
  }

  @override
  String toString() {
    return 'ScanLog(id: $id, ticketId: $ticketId, stationId: $stationId, scanTime: $scanTime, scanType: $scanType, status: $status)';
  }
}
