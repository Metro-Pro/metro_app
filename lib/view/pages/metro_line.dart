import 'package:flutter/material.dart';

class MetroLinePage extends StatefulWidget {
  const MetroLinePage({super.key});

  @override
  MetroLinePageState createState() => MetroLinePageState();
}

class MetroLinePageState extends State<MetroLinePage> {
  final Map<String, Map<String, dynamic>> metroLines = {
    'Line 1': {
      'stations': [
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
      ],
      'color': Colors.blue,
      'status': 'Normal Service',
    },
    'Line 2': {
      'stations': [
        'Shubra El Kheima',
        'Kolleyyet El-Zeraa',
        'Mezallat',
        'Khalafawy',
        'St. Teresa',
        'Rod El-Farag',
        'Massara',
        'Al-Shohadaa',
        'Attaba',
        'Mohamed Naguib',
        'Sadat',
        'Opera',
        'Dokki',
        'El Bohooth',
        'Cairo University',
        'Faisal',
        'Giza',
        'Omm El Misryeen',
        'Sakiat Mekki',
        'El Mounib',
      ],
      'color': Colors.blue,
      'status': 'Normal Service',
    },
    'Line 3': {
      'stations': [
        'Adly Mansour',
        'El Haykestep',
        'Omar Ibn El Khattab',
        'Quba',
        'Hesham Barakat',
        'El Nozha',
        'Nadi El Shams',
        'Alf Maskan',
        'Heliopolis',
        'Haroun',
        'Al Ahram',
        'Koleyet El Banat',
        'Stadium',
        'Fair Zone',
        'Abbassia',
        'Abdou Pasha',
        'Bab El Shaaria',
        'Attaba',
        'Nasser',
        'Maspero',
        'Safaa Hegazy',
        'Kit Kat',
        'Sudan',
        'Imbaba',
        'El Bohooth',
        'Cairo University',
      ],
      'color': Colors.blue,
      'status': 'Normal Service',
    },
  };

  String? fromStation;
  String? toStation;
  String searchQuery = '';

  void _showStationSelectionDialog({required bool isOrigin}) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(33, 33, 33, 1),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search stations...',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.white70),
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
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

                      // Filter stations based on search query
                      final filteredStations = stations
                          .where((station) =>
                              station.toLowerCase().contains(searchQuery))
                          .toList();

                      if (filteredStations.isEmpty) {
                        return const SizedBox.shrink();
                      }

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
                            color:
                                metroLines[line]!['status'] == 'Normal Service'
                                    ? Colors.green[300]
                                    : Colors.orange[300],
                          ),
                        ),
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white70,
                        children: filteredStations
                            .map((station) => ListTile(
                                  contentPadding: const EdgeInsets.only(
                                      left: 72, right: 16),
                                  title: Text(
                                    station,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  onTap: () {
                                    this.setState(() {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            _showStationSelectionDialog(isOrigin: true),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  fromStation ?? 'Select Origin Station',
                                  style: TextStyle(
                                    color: fromStation != null
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        color: Colors.white.withOpacity(0.1),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () =>
                            _showStationSelectionDialog(isOrigin: false),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  toStation ?? 'Select Destination Station',
                                  style: TextStyle(
                                    color: toStation != null
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                InteractiveViewer(
                                  panEnabled: true,
                                  boundaryMargin: const EdgeInsets.all(20),
                                  minScale: 0.5,
                                  maxScale: 4,
                                  child: const Image(
                                    image: AssetImage(
                                        "assets/images/Cairo-Metro-Map.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.white),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Image(
                      image: AssetImage("assets/images/Cairo-Metro-Map.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                if (fromStation != null && toStation != null) ...[
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement journey planning
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Plan Journey',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
