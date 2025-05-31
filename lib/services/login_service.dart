import 'dart:developer';

import 'package:http/http.dart' as http;

class LoginService {
  final String _baseUrl = 'http://127.0.0.1:8000/docs#/auth/login_auth__post';

  Future<bool> login({required String email, required String password}) async {
    final url = Uri.parse('http://127.0.0.1:8000/auth/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      log('Login successful: ${response.body}');
      return true;
    } else {
      log('Login failed: ${response.body}', error: response.statusCode);
      return false;
    }
  }
}
