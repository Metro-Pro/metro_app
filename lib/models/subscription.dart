import 'package:flutter/foundation.dart';

class Subscription {
  final String id;
  final String userId;
  final String planType; // 'monthly', 'quarterly', 'yearly'
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'active', 'expired', 'cancelled'
  final double price;
  final String currency;
  final bool autoRenew;
  final String? paymentMethodId;
  final int? ridesPerMonth;
  final int? ridesUsed;
  final List<String>? allowedLines;

  Subscription({
    required this.id,
    required this.userId,
    required this.planType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.price,
    required this.currency,
    required this.autoRenew,
    this.paymentMethodId,
    this.ridesPerMonth,
    this.ridesUsed,
    this.allowedLines,
  });

  static Subscription fromJson(Map<String, dynamic> json) {
    return Subscription(
      id: json['id'],
      userId: json['userId'],
      planType: json['planType'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      price: json['price'].toDouble(),
      currency: json['currency'],
      autoRenew: json['autoRenew'],
      paymentMethodId: json['paymentMethodId'],
      ridesPerMonth: json['ridesPerMonth'],
      ridesUsed: json['ridesUsed'],
      allowedLines: json['allowedLines'] != null
          ? List<String>.from(json['allowedLines'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'planType': planType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'price': price,
      'currency': currency,
      'autoRenew': autoRenew,
      'paymentMethodId': paymentMethodId,
      'ridesPerMonth': ridesPerMonth,
      'ridesUsed': ridesUsed,
      'allowedLines': allowedLines,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Subscription &&
        other.id == id &&
        other.userId == userId &&
        other.planType == planType &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.status == status &&
        other.price == price &&
        other.currency == currency &&
        other.autoRenew == autoRenew &&
        other.paymentMethodId == paymentMethodId &&
        other.ridesPerMonth == ridesPerMonth &&
        other.ridesUsed == ridesUsed &&
        listEquals(other.allowedLines, allowedLines);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        planType.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        status.hashCode ^
        price.hashCode ^
        currency.hashCode ^
        autoRenew.hashCode ^
        paymentMethodId.hashCode ^
        ridesPerMonth.hashCode ^
        ridesUsed.hashCode ^
        allowedLines.hashCode;
  }

  @override
  String toString() {
    return 'Subscription(id: $id, planType: $planType, startDate: $startDate, endDate: $endDate, status: $status)';
  }
}
