import 'package:flutter/material.dart';
import 'package:metro_app/view/pages/profile.dart';
import 'package:metro_app/view/pages/metro_journey_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> stations = [
    'Helwan',
    'Ain Helwan',
    'Helwan University',
    'Wadi Hof',
    'Hadayek Helwan',
    'El-Maasara',
    'Tora El-Asmant',
    'Kozzika',
    'Tora El-Balad',
    'Sakanat El-Maadi',
    'Maadi',
    'Hadayek El-Maadi',
    'Dar El-Salam',
    'El-Zahraa',
    'Mar Girgis',
    'El-Malek El-Saleh',
    'Al-Sayeda Zeinab',
    'Saad Zaghloul',
    'Sadat',
    'Nasser',
    'Orabi',
    'Al-Shohadaa',
    'Ghamra',
    'El-Demerdash',
    'Manshiet El-Sadr',
    'Kobri El-Qobba',
    'Hammamat El-Qobba',
    'Saray El-Qobba',
    'Hadayeq El-Zaitoun',
    'Helmeyet El-Zaitoun',
    'El-Matareyya',
    'Ain Shams',
    'Ezbet El-Nakhl',
    'El-Marg',
    'New El-Marg'
  ];

  String? fromStation;
  String? toStation;

  bool isCairoMetroPressed = false;
  bool isCapitalTrainPressed = false;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person_outlined,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.nightlight_round,
                          color: Color(0xFFFFD700),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getGreeting(),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Wishing you a smooth journey',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.2),
                        Colors.purple.withOpacity(0.2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCairoMetroPressed = true;
                              isCapitalTrainPressed = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MetroJourneyPage(),
                                ),
                              );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              color: isCairoMetroPressed
                                  ? Colors.blue.withOpacity(0.2)
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.train_rounded,
                                    color: Colors.white70,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Cairo Metro',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isCapitalTrainPressed = true;
                              isCairoMetroPressed = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MetroJourneyPage(),
                                ),
                              );
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                              color: isCapitalTrainPressed
                                  ? Colors.purple.withOpacity(0.2)
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.withOpacity(0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.directions_railway_rounded,
                                    color: Colors.white70,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Capital Train',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xFF4A90E2),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Nearest Station',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF4A90E2),
                        size: 24,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white30,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4A90E2).withOpacity(0.15),
                        const Color(0xFF9B51E0).withOpacity(0.15),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFD700).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.route_rounded,
                              color: Color(0xFFFFD700),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Plan Your Journey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select stations to get journey details and route',
                        style: TextStyle(color: Colors.white60),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: fromStation,
                            hint: const Text(
                              'From',
                              style: TextStyle(color: Colors.white54),
                            ),
                            isExpanded: true,
                            dropdownColor: const Color(0xFF2A2A2A),
                            icon: const Icon(Icons.arrow_drop_down_rounded,
                                color: Colors.white54),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            items: stations.map((String station) {
                              return DropdownMenuItem<String>(
                                value: station,
                                child: Text(station),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                fromStation = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: toStation,
                            hint: const Text(
                              'To',
                              style: TextStyle(color: Colors.white54),
                            ),
                            isExpanded: true,
                            dropdownColor: const Color(0xFF2A2A2A),
                            icon: const Icon(Icons.arrow_drop_down_rounded,
                                color: Colors.white54),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            items: stations.map((String station) {
                              return DropdownMenuItem<String>(
                                value: station,
                                child: Text(station),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                toStation = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: fromStation != null && toStation != null
                              ? () {
                                  // Handle route search
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                            shadowColor:
                                const Color(0xFF4A90E2).withOpacity(0.3),
                            disabledBackgroundColor: Colors.white12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Find Route',
                                style: TextStyle(
                                  color:
                                      fromStation != null && toStation != null
                                          ? Colors.white
                                          : Colors.white54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
          ),
        ),
      ),
    );
  }
}
