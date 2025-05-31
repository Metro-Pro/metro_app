import 'package:flutter/material.dart';
import 'package:metro_app/view/pages/payment.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 20,
              ),
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
                        fontSize: value != null ? 12 : 14,
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

  // Cairo Metro stations
  final List<Station> stations = const [
    // Line 1
    Station('Helwan', 3),
    Station('Ain Helwan', 3),
    Station('Helwan University', 3),
    Station('Wadi Hof', 3),
    Station('Hadayek Helwan', 3),
    Station('El-Maasara', 3),
    Station('Tora El-Asmant', 3),
    Station('Kozzika', 3),
    Station('Tora El-Balad', 3),
    Station('Sakanat El-Maadi', 3),
    Station('Maadi', 3),
    Station('Hadayek El-Maadi', 3),
    Station('Dar El-Salam', 3),
    Station('El-Zahraa', 3),
    Station('Mar Girgis', 3),
    Station('El-Malek El-Saleh', 3),
    Station('Al-Sayeda Zeinab', 3),
    Station('Saad Zaghloul', 3),
    Station('Sadat', 3),
    Station('Nasser', 3),
    Station('Orabi', 3),
    Station('Al-Shohadaa', 3),
    Station('Ghamra', 3),
    Station('El-Demerdash', 3),
    Station('Manshiet El-Sadr', 3),
    Station('Kobri El-Qobba', 3),
    Station('Hammamat El-Qobba', 3),
    Station('Saray El-Qobba', 3),
    Station('Hadayeq El-Zaitoun', 3),
    Station('Helmeyet El-Zaitoun', 3),
    Station('El-Matareyya', 3),
    Station('Ain Shams', 3),
    Station('Ezbet El-Nakhl', 3),
    Station('El-Marg', 3),
    // Line 2
    Station('Shubra El Kheima', 3),
    Station('Kolleyyet El-Zeraa', 3),
    Station('Mezallat', 3),
    Station('Khalafawy', 3),
    Station('St. Teresa', 3),
    Station('Rod El-Farag', 3),
    Station('Massara', 3),
    Station('Al-Shohadaa', 3),
    Station('Attaba', 3),
    Station('Mohamed Naguib', 3),
    Station('Sadat', 3),
    Station('Opera', 3),
    Station('Dokki', 3),
    Station('El Bohooth', 3),
    Station('Cairo University', 3),
    Station('Faisal', 3),
    Station('Giza', 3),
    Station('Omm El Misryeen', 3),
    Station('Sakiat Mekki', 3),
    Station('El Mounib', 3),
    // Line 3
    Station('Adly Mansour', 3),
    Station('El Haykestep', 3),
    Station('Omar Ibn El Khattab', 3),
    Station('Quba', 3),
    Station('Hesham Barakat', 3),
    Station('El Nozha', 3),
    Station('Nadi El Shams', 3),
    Station('Alf Maskan', 3),
    Station('Heliopolis', 3),
    Station('Haroun', 3),
    Station('Al Ahram', 3),
    Station('Koleyet El Banat', 3),
    Station('Stadium', 3),
    Station('Fair Zone', 3),
    Station('Abbassia', 3),
    Station('Abdou Pasha', 3),
    Station('Bab El Shaaria', 3),
    Station('Attaba', 3),
    Station('Nasser', 3),
    Station('Maspero', 3),
    Station('Safaa Hegazy', 3),
    Station('Kit Kat', 3),
    Station('Sudan', 3),
    Station('Imbaba', 3),
    Station('El Bohooth', 3),
    Station('Cairo University', 3),
  ];

  int getStationsCount() {
    if (fromStation == null || toStation == null) return 0;
    final fromIndex = stations.indexWhere((s) => s.name == fromStation!.name);
    final toIndex = stations.indexWhere((s) => s.name == toStation!.name);
    if (fromIndex == -1 || toIndex == -1) return 0;
    return (toIndex - fromIndex).abs() + 1;
  }

  double calculateSingleJourneyPrice() {
    final stationsCount = getStationsCount();
    if (stationsCount >= 1 && stationsCount <= 9) return 8.0;
    if (stationsCount >= 10 && stationsCount <= 16) return 10.0;
    if (stationsCount >= 17 && stationsCount <= 23) return 15.0;
    if (stationsCount > 23) return 20.0;
    return 0.0;
  }

  double calculateTicketPrice(String type) {
    if (fromStation == null || toStation == null) return 0.0;
    if (type == '1-Day Pass') return 20.0;
    if (type == '3-Day Pass') return 50.0;
    if (type == '7-Day Pass') return 100.0;
    return 0.0;
  }

  void _showQRCode(BuildContext context) {
    if (selectedTicketType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a ticket type first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTicketType!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: QrImageView(
                  data: '''
                    Ticket Type: $selectedTicketType
                    From: ${fromStation?.name ?? 'N/A'}
                    To: ${toStation?.name ?? 'N/A'}
                    Price: EGP ${ticketPrice.toStringAsFixed(0)}
                    Date: ${DateTime.now().toString()}
                  ''',
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _getValidityText(),
                  style: TextStyle(
                    color: Colors.orange[300],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (fromStation != null && toStation != null)
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'From: ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            fromStation!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'To: ',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            toStation!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.blue),
                label: const Text(
                  'Close',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  String _getValidityText() {
    switch (selectedTicketType) {
      case 'Single Journey':
        return 'Valid for 2 hours';
      case '1-Day Pass':
        return 'Valid for 24 hours';
      case '3-Day Pass':
        return 'Valid for 3 days';
      case '7-Day Pass':
        return 'Valid for 7 days';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Buy Ticket',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.qr_code, color: Colors.white),
              onPressed: () => _showQRCode(context),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'From',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SearchableDropdown(
                    label: 'Select Station',
                    value: fromStation,
                    items: stations,
                    onChanged: (station) {
                      setState(() {
                        fromStation = station;
                        if (selectedTicketType != null) {
                          ticketPrice =
                              calculateTicketPrice(selectedTicketType!);
                        }
                      });
                    },
                    isFrom: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'To',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SearchableDropdown(
                    label: 'Select Station',
                    value: toStation,
                    items: stations,
                    onChanged: (station) {
                      setState(() {
                        toStation = station;
                        if (selectedTicketType != null) {
                          ticketPrice =
                              calculateTicketPrice(selectedTicketType!);
                        }
                      });
                    },
                    isFrom: false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Select Ticket Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Only Single Journey Option
              InkWell(
                onTap: () {
                  setState(() {
                    selectedTicketType = 'Single Journey';
                    ticketPrice = calculateSingleJourneyPrice();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedTicketType == 'Single Journey'
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selectedTicketType == 'Single Journey'
                          ? Colors.blue
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedTicketType == 'Single Journey'
                                ? Colors.blue
                                : Colors.white70,
                            width: 2,
                          ),
                        ),
                        child: selectedTicketType == 'Single Journey'
                            ? const Icon(
                                Icons.check,
                                color: Colors.blue,
                                size: 16,
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Single Journey',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'EGP ${calculateSingleJourneyPrice().toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              if (fromStation != null &&
                  toStation != null &&
                  selectedTicketType != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Journey Summary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              fromStation!.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.blue),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              toStation!.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'EGP ${ticketPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            amount: ticketPrice,
                            paymentType: 'ticket',
                            description: selectedTicketType!,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Payment',
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
    );
  }
}
