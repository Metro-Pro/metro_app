import 'package:flutter/material.dart';
import 'package:metro_app/view/pages/home.dart';
import 'package:metro_app/view/pages/metro_line.dart';
import 'package:metro_app/view/pages/payment.dart';
import 'package:metro_app/view/pages/subscription.dart';
import 'package:metro_app/view/pages/ticket.dart';

class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  List<Widget> pages = [
    const HomeScreen(),
    const SubscriptionPage(),
    const PaymentPage(amount: 0.0),
    const TicketPage(),
    const MetroLinePage()
  ];
  int index = 0;
  Color unselectedItemColor = Colors.grey;
  Color selectedItemColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
        },
        backgroundColor: const Color.fromRGBO(33, 33, 33, 1.0),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_rounded),
            label: 'subscription',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment_rounded),
            label: 'payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership_outlined),
            label: 'ticket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.train_rounded),
            label: 'metro line',
          ),
        ],
      ),
    );
  }
}
