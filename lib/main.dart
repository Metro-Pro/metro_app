import 'package:flutter/material.dart';
import 'package:metro_app/view/pages/screen_wrapper.dart';

// import 'package:metro_app/view/pages/login.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenWrapper(),
    );
  }
}
