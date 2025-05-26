import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:metro_app/view/pages/home.dart';
import 'package:metro_app/view/pages/metro_line.dart';
import 'package:metro_app/view/pages/ticket.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentOptions = [
      {'icon': Icons.credit_card, 'title': 'Credit Card'},
      {'icon': Icons.account_balance_wallet, 'title': 'Wallet'},
      {'icon': Icons.paypal, 'title': 'PayPal'},
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/Group 5.svg",
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            itemCount: paymentOptions.length,
            itemBuilder: (context, index) {
              final option = paymentOptions[index];
              return ListTile(
                leading: Icon(option['icon'] as IconData, color: const Color.fromRGBO(255, 255, 255, 1.0)),
                title: Text(option['title'] as String, style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1.0))),
                tileColor: const Color.fromRGBO(33, 33, 33, 1.0),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Handle payment option selection
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: \\${option['title']}')),
                  );
                },
              );
            },
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
