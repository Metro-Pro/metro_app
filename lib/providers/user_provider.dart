// import 'package:flutter/foundation.dart';
// import 'package:metro_app/models/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserProvider with ChangeNotifier {
//   User? _user;
//   final _prefs = SharedPreferences.getInstance();

//   User? get user => _user;

//   Future<void> setUser(User user) async {
//     _user = user;
//     final prefs = await _prefs;
//     await prefs.setString('user', user.toJson().toString());
//     notifyListeners();
//   }

//   Future<void> loadUser() async {
//     final prefs = await _prefs;
//     final userJson = prefs.getString('user');
//     if (userJson != null) {
//       // Parse the JSON string back to a Map
//       final Map<String, dynamic> userMap = Map<String, dynamic>.from(
//         Map<String, dynamic>.from(
//           userJson as Map<String, dynamic>,
//         ),
//       );
//       _user = User.fromJson(userMap);
//       notifyListeners();
//     }
//   }

//   Future<void> clearUser() async {
//     _user = null;
//     final prefs = await _prefs;
//     await prefs.remove('user');
//     notifyListeners();
//   }
// }
