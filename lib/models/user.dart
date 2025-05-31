class User {
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String phone;
  final String password;

  User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.username == username &&
        other.email == email &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode {
    return firstname.hashCode ^
        lastname.hashCode ^
        username.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        password.hashCode;
  }

  @override
  String toString() {
    return 'User(firstname: $firstname, lastname: $lastname, username: $username, email: $email, phone: $phone)';
  }
}
