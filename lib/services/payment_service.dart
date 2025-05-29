// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:metro_app/services/wallet_service.dart';

// class PaymentService {
//   // These would need backend configuration
//   // static const String _stripePublishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
//   // static const String _backendUrl = 'YOUR_BACKEND_URL';
//   // static const String _paypalClientId = 'YOUR_PAYPAL_CLIENT_ID';
//   // static const String _paypalSecretKey = 'YOUR_PAYPAL_SECRET_KEY';

//   // This would need backend initialization
//   // static Future<void> initialize() async {
//   //   Stripe.publishableKey = _stripePublishableKey;
//   //   await Stripe.instance.applySettings();
//   // }

//   static Future<bool> processPayment({
//     required String paymentMethod,
//     required double amount,
//     required BuildContext context,
//   }) async {
//     try {
//       await Future.delayed(const Duration(seconds: 2));

//       switch (paymentMethod) {
//         case 'Credit Card':
//           // This would need Stripe backend integration
//           // final response = await http.post(Uri.parse('$_backendUrl/create-payment-intent'));
//           // final paymentIntent = await Stripe.instance.confirmPayment(response.clientSecret);
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                   content: Text('Demo: Credit card payment successful')),
//             );
//           }
//           return true;

//         case 'Wallet':
//           final success = await WalletService.deductAmount(amount);
//           if (!success && context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Insufficient wallet balance')),
//             );
//             return false;
//           }
//           return success;

//         case 'PayPal':
//           // This would need PayPal backend integration
//           // final result = await Navigator.of(context).push(
//           //   MaterialPageRoute(
//           //     builder: (context) => UsePaypal(
//           //       sandboxMode: true,
//           //       clientId: _paypalClientId,
//           //       secretKey: _paypalSecretKey,
//           //       returnURL: "https://samplesite.com/return",
//           //       cancelURL: "https://samplesite.com/cancel",
//           //       transactions: [{
//           //         "amount": {
//           //           "total": amount.toString(),
//           //           "currency": "USD",
//           //         },
//           //       }],
//           //     ),
//           //   ),
//           // );
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Demo: PayPal payment successful')),
//             );
//           }
//           return true;

//         default:
//           throw Exception('Unsupported payment method');
//       }
//     } catch (e) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Payment failed: ${e.toString()}')),
//         );
//       }
//       return false;
//     }
//   }

//   static Future<bool> _processCreditCardPayment(double amount) async {
//     try {
//       // Create payment intent
//       final response = await http.post(
//         Uri.parse('$_backendUrl/create-payment-intent'),
//         body: {
//           'amount': (amount * 100).toInt().toString(), // Convert to cents
//           'currency': 'usd',
//         },
//       );

//       final paymentIntent = jsonDecode(response.body);

//       // Initialize payment sheet
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent['clientSecret'],
//           merchantDisplayName: 'Metro App',
//         ),
//       );

//       // Present payment sheet
//       await Stripe.instance.presentPaymentSheet();

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> _processPayPalPayment(
//       BuildContext context, double amount) async {
//     bool isSuccess = false;
//     try {
//       if (!context.mounted) return false;
//       await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => UsePaypal(
//             sandboxMode: true,
//             clientId: _paypalClientId,
//             secretKey: _paypalSecretKey,
//             returnURL: "https://samplesite.com/return",
//             cancelURL: "https://samplesite.com/cancel",
//             transactions: [
//               {
//                 "amount": {
//                   "total": amount.toString(),
//                   "currency": "USD",
//                 },
//                 "description": "Metro App Payment",
//               }
//             ],
//             onSuccess: (Map params) {
//               isSuccess = true;
//             },
//             onError: (error) {
//               isSuccess = false;
//             },
//             onCancel: (params) {
//               isSuccess = false;
//             },
//           ),
//         ),
//       );
//       return isSuccess;
//     } catch (e) {
//       return false;
//     }
//   }
// }
