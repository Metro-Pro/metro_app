import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:metro_app/view/pages/home.dart';
import 'package:metro_app/view/pages/payment.dart';
import 'package:metro_app/view/pages/ticket.dart';

class MetroLinePage extends StatefulWidget {
  @override
  _MetroLinePageState createState() => _MetroLinePageState();
}

class _MetroLinePageState extends State<MetroLinePage> {
  final Map<String, List<String>> metroLines = {
    'Red Line': ['Station A', 'Station B', 'Station C', 'Station D'],
    'Blue Line': ['Station E', 'Station F', 'Station G'],
    'Green Line': ['Station H', 'Station I', 'Station J', 'Station K'],
  };

  String? selectedLine;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  hint: Text('Select a Metro Line', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)), ),
                  value: selectedLine,
                  dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                  focusColor: Color.fromRGBO(255, 255, 255, 1),
                  isExpanded: true,
                  items: metroLines.keys.map((line) {
                    return DropdownMenuItem(
                      value: line,
                      child: Text(line, style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)), ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLine = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                if (selectedLine != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: metroLines[selectedLine]!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.train, color: Color.fromRGBO(255, 255, 255, 1),),
                          title: Text(metroLines[selectedLine]![index], style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
                        );
                      },
                    ),
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
