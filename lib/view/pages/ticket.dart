import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metro_app/view/pages/home.dart';
import 'package:metro_app/view/pages/metro_line.dart';
import 'package:metro_app/view/pages/payment.dart';

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  String? fromStation;
  String? toStation;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  double ticketPrice = 0.0;

  final List<String> stations = [
    'Station A',
    'Station B',
    'Station C',
    'Station D',
  ];

  void calculatePrice() {
    // Simple price calculation based on station index difference
    if (fromStation != null && toStation != null) {
      int fromIndex = stations.indexOf(fromStation!);
      int toIndex = stations.indexOf(toStation!);
      ticketPrice = (fromIndex - toIndex).abs() * 2.5 + 5;
    } else {
      ticketPrice = 0.0;
    }
  }

  Future<void> pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    calculatePrice();

    return Scaffold(
      
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Group 5.svg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 40.0)),
                DropdownButtonFormField<String>(
                  dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                  decoration: InputDecoration(labelText: 'From',fillColor: Color.fromRGBO(
            33, 33, 33, 0), filled: true, labelStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  value: fromStation,
                  items: stations
                      .map((station) => DropdownMenuItem(
                            
                            value: station,
                            child: Text(station, style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      fromStation = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                  decoration: InputDecoration(labelText: 'To',fillColor: Color.fromRGBO(
            33, 33, 33, 0), filled: true, labelStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  value: toStation,
                  items: stations
                      .map((station) => DropdownMenuItem(
                            value: station,
                            child: Text(station, style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      toStation = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text(selectedDate == null
                      ? 'Select Date'
                      : 'Date: ${selectedDate!.toLocal().toString().split(' ')[0]}', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  trailing: Icon(Icons.calendar_today, color: Color.fromRGBO(255, 255, 255, 1)),
                  onTap: pickDate,
                ),
                ListTile(
                  title: Text(selectedTime == null
                      ? 'Select Time'
                      : 'Time: ${selectedTime!.format(context)}', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1))),
                  trailing: Icon(Icons.access_time, color: Color.fromRGBO(255, 255, 255, 1)),
                  onTap: pickTime,
                ),
                SizedBox(height: 16),
                Text(
                  'Price: \$${ticketPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(255, 255, 255, 1)),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: (fromStation != null &&
                          toStation != null &&
                          selectedDate != null &&
                          selectedTime != null)
                      ? () {
                          // Confirm ticket logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ticket Confirmed!')),
                          );
                        }
                      : null,
                  child: Text('Confirm Ticket'),
                ),
              ],
            ),
          ),
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
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.home_rounded,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPage(),
                  ),
                );
              },
              child: Icon(
                Icons.payment_rounded,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
            label: 'payment',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPage(),
                  ),
                );
              },
              child: Icon(
                Icons.card_membership_outlined,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
            label: 'ticket',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MetroLinePage(),
                  ),
                );
              },
              child: Icon(
                Icons.train_rounded,
                color: const Color.fromRGBO(255, 255, 255, 1.0),
              ),
            ),
            label: 'metro line',
          ),
        ],
      ),
    );
  }
}
