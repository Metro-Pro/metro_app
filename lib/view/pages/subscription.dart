import 'package:flutter/material.dart';
import 'package:metro_app/view/pages/payment.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(33, 33, 33, 1.0),
        title: const Text(
          'Subscription Plans',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildSubscriptionCard(
                title: 'Monthly Pass',
                price: 'EGP 200',
                features: [
                  'Unlimited metro rides for 30 days',
                  'Valid on all metro lines',
                  'Free transfers between lines',
                  'Priority boarding during peak hours',
                  '24/7 customer support',
                ],
                isPopular: false,
              ),
              const SizedBox(height: 16),
              _buildSubscriptionCard(
                title: 'Quarterly Pass',
                price: 'EGP 500',
                features: [
                  'Unlimited metro rides for 90 days',
                  'Valid on all metro lines',
                  'Free transfers between lines',
                  'Priority boarding during peak hours',
                  '24/7 customer support',
                  '10% discount on food at metro stations',
                ],
                isPopular: true,
              ),
              const SizedBox(height: 16),
              _buildSubscriptionCard(
                title: 'Annual Pass',
                price: 'EGP 1,800',
                features: [
                  'Unlimited metro rides for 365 days',
                  'Valid on all metro lines',
                  'Free transfers between lines',
                  'Priority boarding during peak hours',
                  '24/7 customer support',
                  '20% discount on food at metro stations',
                  'Free parking at selected stations',
                  'Exclusive access to metro events',
                ],
                isPopular: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String> features,
    required bool isPopular,
  }) {
    // Extract the numeric price from the string (remove EGP and convert to double)
    final double amount =
        double.parse(price.replaceAll('EGP ', '').replaceAll(',', ''));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? Colors.blue : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPopular)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Most Popular',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(
                        amount: amount,
                        paymentType: 'subscription',
                        description: title,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPopular ? Colors.blue : Colors.grey[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
