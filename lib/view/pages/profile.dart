import 'package:metro_app/view/pages/edit_profile.dart';
import 'package:metro_app/view/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metro_app/view/pages/login.dart';
import 'package:metro_app/view/pages/settings.dart';

class Profile extends StatelessWidget {
  // final String name;

  // const Profile({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(
                255, 255, 255, 1), // Corrected font color property
          ),
          textAlign: TextAlign.center, // Fixed text alignment
        ),
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Group 5.svg",
              fit: BoxFit.cover,
            ),
          ),

          // Profile Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50), // Spacer to push content down
                CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  // backgroundImage:
                  //     AssetImage("assets/images/profile_picture.png"),
                ),
                SizedBox(height: 12),
                Text(
                  // name,
                  "",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "username@example.com",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),

                // Profile Options
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.blue),
                          title: Text("edit profile"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfilePage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: Colors.blue),
                          title: Text("Settings"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.black),
                          title: Text("Logout"),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
