import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawer: Drawer(),
      body: const Center(
        child: Text("SignUp",
          style: TextStyle(color: Color.fromARGB(255, 244, 131, 131)),
      ),
    )
    );
  }
}
