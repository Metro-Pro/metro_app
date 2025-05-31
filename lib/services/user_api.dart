import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserApi {
  // final String _baseUrl = 'http://127.0.0.1:8000/docs#/Users/create_user_route_users__post';

  Future<User?> createUser(User user) async {
    final url = Uri.parse('http://127.0.0.1:8000/users/?skip=0&limit=100');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      debugPrint('Failed to create user: \\${response.body}');
      return null;
    }
  }
}
