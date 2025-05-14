import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                            // Profile icon tapped
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
                        // SvgPicture.asset(
                        //   "assets/images/Group 4.svg",
                        //   width: 20.0,
                        //   height: 19.0,
                        //   fit: BoxFit.contain,
                        // ),
                        const SizedBox(
                            width:
                                30.0), // Placeholder for alignment or a future button
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 1030),
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
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
