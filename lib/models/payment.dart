class Payment {
  final String id;
  final String userId;
  final double amount;
  final String currency;
  final String status; // 'pending', 'completed', 'failed', 'refunded'
  final String paymentMethod;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? transactionId;
  final String? description;

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    this.completedAt,
    this.transactionId,
    this.description,
  });

  static Payment fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'])
          : null,
      transactionId: json['transactionId'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'transactionId': transactionId,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Payment &&
        other.id == id &&
        other.userId == userId &&
        other.amount == amount &&
        other.currency == currency &&
        other.status == status &&
        other.paymentMethod == paymentMethod &&
        other.createdAt == createdAt &&
        other.completedAt == completedAt &&
        other.transactionId == transactionId &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        status.hashCode ^
        paymentMethod.hashCode ^
        createdAt.hashCode ^
        completedAt.hashCode ^
        transactionId.hashCode ^
        description.hashCode;
  }

  @override
  String toString() {
    return 'Payment(id: $id, amount: $amount $currency, status: $status, paymentMethod: $paymentMethod)';
  }
}
