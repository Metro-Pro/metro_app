class User {
  final String name;
  final String email;
  final String phone;
  final String? profilePicture;

  User({
    required this.name,
    required this.email,
    required this.phone,
    this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      profilePicture: json['profilePicture'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        profilePicture.hashCode;
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, phone: $phone)';
  }
}
