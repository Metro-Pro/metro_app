import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MetroLinePage extends StatefulWidget {
  const MetroLinePage({super.key});

  @override
  MetroLinePageState createState() => MetroLinePageState();
}

class MetroLinePageState extends State<MetroLinePage> {
  final Map<String, Map<String, dynamic>> metroLines = {
    'Red Line': {
      'stations': ['Station A', 'Station B', 'Station C', 'Station D'],
      'color': Colors.red,
      'status': 'Normal Service',
    },
    'Blue Line': {
      'stations': ['Station E', 'Station F', 'Station G'],
      'color': Colors.blue,
      'status': 'Minor Delays',
    },
    'Green Line': {
      'stations': ['Station H', 'Station I', 'Station J', 'Station K'],
      'color': Colors.green,
      'status': 'Normal Service',
    },
  };

  String? fromStation;
  String? toStation;

  void _showStationSelectionDialog({required bool isOrigin}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isOrigin
                      ? 'Select Origin Station'
                      : 'Select Destination Station',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: metroLines.length,
                  itemBuilder: (context, lineIndex) {
                    final line = metroLines.keys.elementAt(lineIndex);
                    final stations =
                        metroLines[line]!['stations'] as List<String>;
                    final lineColor = metroLines[line]!['color'] as Color;

                    return ExpansionTile(
                      leading: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: lineColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: lineColor.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.train,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      title: Text(
                        line,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        metroLines[line]!['status'] as String,
                        style: TextStyle(
                          color: metroLines[line]!['status'] == 'Normal Service'
                              ? Colors.green[300]
                              : Colors.orange[300],
                        ),
                      ),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.white70,
                      children: stations
                          .map((station) => ListTile(
                                contentPadding:
                                    const EdgeInsets.only(left: 72, right: 16),
                                title: Text(
                                  station,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (isOrigin) {
                                      fromStation = station;
                                    } else {
                                      toStation = station;
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Plan Your Journey',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SvgPicture.asset(
                                  "assets/images/image_2.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SvgPicture.asset(
                    "assets/images/image_2.svg",
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // From Station Selection
              InkWell(
                onTap: () => _showStationSelectionDialog(isOrigin: true),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: fromStation != null ? Colors.blue : Colors.white24,
                      width: fromStation != null ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'From',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: fromStation != null ? 12 : 14,
                              ),
                            ),
                            if (fromStation != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                fromStation!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white70),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // To Station Selection
              InkWell(
                onTap: () => _showStationSelectionDialog(isOrigin: false),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: toStation != null ? Colors.blue : Colors.white24,
                      width: toStation != null ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white70),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'To',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: toStation != null ? 12 : 14,
                              ),
                            ),
                            if (toStation != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                toStation!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down,
                          color: Colors.white70),
                    ],
                  ),
                ),
              ),
              if (fromStation != null && toStation != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Route Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.access_time, color: Colors.white70),
                          const SizedBox(width: 8),
                          const Text(
                            'Estimated Time: ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '25 mins',
                            style: TextStyle(
                              color: Colors.green[300],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.train, color: Colors.white70),
                          const SizedBox(width: 8),
                          const Text(
                            'Next Train: ',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '3 mins',
                            style: TextStyle(
                              color: Colors.orange[300],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
