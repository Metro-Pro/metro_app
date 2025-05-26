import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Account'),
                onTap: () {
                  // Navigate to account settings
                },
              ),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Privacy'),
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  // Navigate to about page
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
