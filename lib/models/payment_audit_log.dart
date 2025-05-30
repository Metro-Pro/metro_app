class PaymentAuditLog {
  final String id;
  final String paymentId;
  final String userId;
  final DateTime timestamp;
  final String action; // 'created', 'completed', 'failed', 'refunded'
  final String status;
  final String details;
  final double amount;

  PaymentAuditLog({
    required this.id,
    required this.paymentId,
    required this.userId,
    required this.timestamp,
    required this.action,
    required this.status,
    required this.details,
    required this.amount,
  });

  static PaymentAuditLog fromJson(Map<String, dynamic> json) {
    return PaymentAuditLog(
      id: json['id'],
      paymentId: json['paymentId'],
      userId: json['userId'],
      timestamp: DateTime.parse(json['timestamp']),
      action: json['action'],
      status: json['status'],
      details: json['details'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'paymentId': paymentId,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'action': action,
      'status': status,
      'details': details,
      'amount': amount,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentAuditLog &&
        other.id == id &&
        other.paymentId == paymentId &&
        other.userId == userId &&
        other.timestamp == timestamp &&
        other.action == action &&
        other.status == status &&
        other.details == details &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        paymentId.hashCode ^
        userId.hashCode ^
        timestamp.hashCode ^
        action.hashCode ^
        status.hashCode ^
        details.hashCode ^
        amount.hashCode;
  }

  @override
  String toString() {
    return 'PaymentAuditLog(id: $id, paymentId: $paymentId, action: $action, status: $status, amount: $amount)';
  }
}
