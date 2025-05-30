class Ticket {
  final String id;
  final String userId;
  final String ticketType; // 'single', 'daily', 'weekly', 'monthly'
  final DateTime validFrom;
  final DateTime validUntil;
  final String status; // 'active', 'used', 'expired', 'cancelled'
  final double price;
  final String currency;
  final String? sourceStation;
  final String? destinationStation;
  final int? numberOfRides;
  final int? ridesUsed;

  Ticket({
    required this.id,
    required this.userId,
    required this.ticketType,
    required this.validFrom,
    required this.validUntil,
    required this.status,
    required this.price,
    required this.currency,
    this.sourceStation,
    this.destinationStation,
    this.numberOfRides,
    this.ridesUsed,
  });

  static Ticket fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      userId: json['userId'],
      ticketType: json['ticketType'],
      validFrom: DateTime.parse(json['validFrom']),
      validUntil: DateTime.parse(json['validUntil']),
      status: json['status'],
      price: json['price'].toDouble(),
      currency: json['currency'],
      sourceStation: json['sourceStation'],
      destinationStation: json['destinationStation'],
      numberOfRides: json['numberOfRides'],
      ridesUsed: json['ridesUsed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'ticketType': ticketType,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'status': status,
      'price': price,
      'currency': currency,
      'sourceStation': sourceStation,
      'destinationStation': destinationStation,
      'numberOfRides': numberOfRides,
      'ridesUsed': ridesUsed,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ticket &&
        other.id == id &&
        other.userId == userId &&
        other.ticketType == ticketType &&
        other.validFrom == validFrom &&
        other.validUntil == validUntil &&
        other.status == status &&
        other.price == price &&
        other.currency == currency &&
        other.sourceStation == sourceStation &&
        other.destinationStation == destinationStation &&
        other.numberOfRides == numberOfRides &&
        other.ridesUsed == ridesUsed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        ticketType.hashCode ^
        validFrom.hashCode ^
        validUntil.hashCode ^
        status.hashCode ^
        price.hashCode ^
        currency.hashCode ^
        sourceStation.hashCode ^
        destinationStation.hashCode ^
        numberOfRides.hashCode ^
        ridesUsed.hashCode;
  }

  @override
  String toString() {
    return 'Ticket(id: $id, type: $ticketType, validFrom: $validFrom, validUntil: $validUntil, status: $status)';
  }
}
