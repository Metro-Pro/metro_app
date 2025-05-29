import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Station {
  final String name;
  final int estimatedWaitMin;

  const Station(this.name, this.estimatedWaitMin);
}

class SearchableDropdown extends StatelessWidget {
  final String label;
  final Station? value;
  final List<Station> items;
  final Function(Station?) onChanged;
  final bool isFrom;

  const SearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.isFrom,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => StationSearchDialog(
              stations: items,
              onSelect: onChanged,
              isFrom: isFrom,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: value != null
                            ? 12
                            : 14, // Smaller when station is selected
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value?.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight:
                            value != null ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}

class StationSearchDialog extends StatefulWidget {
  final List<Station> stations;
  final Function(Station?) onSelect;
  final bool isFrom;

  const StationSearchDialog({
    super.key,
    required this.stations,
    required this.onSelect,
    required this.isFrom,
  });

  @override
  State<StationSearchDialog> createState() => _StationSearchDialogState();
}

class _StationSearchDialogState extends State<StationSearchDialog> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Station> get filteredStations {
    if (searchQuery.isEmpty) return widget.stations;
    return widget.stations
        .where((station) =>
            station.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(33, 33, 33, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search stations',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white70),
                  filled: true,
                  fillColor: Colors.black45,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
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
                itemCount: filteredStations.length,
                itemBuilder: (context, index) {
                  final station = filteredStations[index];
                  return ListTile(
                    title: Text(
                      station.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      widget.onSelect(station);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  TicketPageState createState() => TicketPageState();
}

class TicketPageState extends State<TicketPage> {
  Station? fromStation;
  Station? toStation;
  String? selectedTicketType;
  double ticketPrice = 0.0;

  // Realistic metro stations
  final List<Station> stations = const [
    Station('Central Station', 3),
    Station('City Square', 4),
    Station('Business District', 5),
    Station('University Campus', 6),
    Station('Sports Complex', 7),
    Station('Shopping Mall', 4),
    Station('Airport Express', 8),
    Station('Tech Park', 6),
    Station('Riverside', 5),
    Station('Convention Center', 4),
  ];

  final List<String> ticketTypes = [
    'Single Journey',
    '1-Day Pass',
    '3-Day Pass',
    '7-Day Pass'
  ];

  // Peak hours are 7-9 AM and 5-7 PM
  bool isCurrentlyPeakHours() {
    final now = TimeOfDay.now();
    final hour = now.hour;
    return (hour >= 7 && hour < 9) || (hour >= 17 && hour < 19);
  }

  String getFrequencyText(Station station) {
    final isPeak = isCurrentlyPeakHours();
    final baseWait = station.estimatedWaitMin;
    final waitTime = isPeak ? baseWait : baseWait * 2;

    return 'Next train in ~$waitTime mins';
  }

  double calculateTicketPrice(String type) {
    if (fromStation == null || toStation == null) return 0.0;

    // Base price for a journey
    double basePrice = 2.50;

    // Multiply base price based on ticket type
    switch (type) {
      case '1-Day Pass':
        return basePrice * 2.5;
      case '3-Day Pass':
        return basePrice * 6;
      case '7-Day Pass':
        return basePrice * 12;
      default: // Single Journey
        return basePrice;
    }
  }

  void updatePrice() {
    if (selectedTicketType != null) {
      setState(() {
        ticketPrice = calculateTicketPrice(selectedTicketType!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPeakHour = isCurrentlyPeakHours();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Group 5.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.train, color: Colors.white, size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        'Metro Ticket',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isPeakHour
                              ? Colors.orange.withOpacity(0.2)
                              : Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isPeakHour ? 'Peak Hours' : 'Off-Peak',
                          style: TextStyle(
                            color: isPeakHour
                                ? Colors.orange[300]
                                : Colors.green[300],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Journey Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SearchableDropdown(
                                label: 'From',
                                value: fromStation,
                                items: stations,
                                onChanged: (value) {
                                  setState(() {
                                    fromStation = value;
                                    updatePrice();
                                  });
                                },
                                isFrom: true,
                              ),
                              if (fromStation != null) ...[
                                const SizedBox(height: 4),
                              ],
                              const SizedBox(height: 16),
                              SearchableDropdown(
                                label: 'To',
                                value: toStation,
                                items: stations,
                                onChanged: (value) {
                                  setState(() {
                                    toStation = value;
                                    updatePrice();
                                  });
                                },
                                isFrom: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ticket Type',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: ticketTypes.map((type) {
                                  final isSelected = selectedTicketType == type;
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedTicketType = type;
                                        updatePrice();
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.black26,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.blue
                                              : Colors.white24,
                                        ),
                                      ),
                                      child: Text(
                                        type,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.white70,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Fare Details',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Fare',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '\$${ticketPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (fromStation != null && toStation != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Valid for travel between ${fromStation!.name} and ${toStation!.name}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                if (selectedTicketType != null &&
                                    selectedTicketType != 'Single Journey')
                                  Text(
                                    'Valid for ${selectedTicketType!.split(" ")[0]} of unlimited travel',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: (fromStation != null &&
                                    toStation != null &&
                                    selectedTicketType != null)
                                ? () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Ticket Purchased! Tap your phone at the gate to enter.'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Purchase Ticket',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
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
        ],
      ),
    );
  }
}
