import 'package:flutter/material.dart';
import 'package:metro_app/features/map_page/presentation/pages/map_page.dart';
import 'package:metro_app/view/pages/screen_wrapper.dart';

// import 'package:metro_app/view/pages/login.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}
