import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metro_app/view/pages/profile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Group 5.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Handle back button tap
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.person_outlined,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                30.0), // Placeholder for alignment or a future button
                        GestureDetector(
                          onTap: () {
                            // Handle back button tap
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                            ),
                            child: const Icon(
                              Icons.notifications_active_rounded,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 750),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 30),
                            const SizedBox(width: 15),
                            const SizedBox(width: 15),
                            const SizedBox(width: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(
            33, 33, 33, 1.0), // Adjust color and opacity as needed
        selectedItemColor: const Color.fromRGBO(255, 255, 255, 1.0),
        unselectedItemColor: const Color.fromRGBO(215, 255, 255, 1.0),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.payments_outlined,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            label: 'payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership_outlined,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            label: 'ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.train_outlined,
              color: const Color.fromRGBO(255, 255, 255, 1.0),
            ),
            label: 'metro line',
          ),
        ],
      ),
    );
  }
}
