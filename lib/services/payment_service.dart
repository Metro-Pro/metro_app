import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentService {
  static const String _backendUrl =
      'http://127.0.0.1:8000/docs#/Payments/redirect_to_paymob_payments_pay_getL'; // Set your FastAPI backend URL

  static Future<bool> processPayment({
    required String paymentMethod,
    required double amount,
    required BuildContext context,
  }) async {
    try {
      switch (paymentMethod) {
        case 'Credit Card':
          return await _processCreditCardPayment(context, amount);
        case 'Wallet':
          return await _processWalletPayment(context, amount);
        case 'PayPal':
          return await _processPayPalPayment(context, amount);
        default:
          throw Exception('Unsupported payment method');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment failed: [${e.toString()}')),
        );
      }
      return false;
    }
  }

  static Future<bool> _processCreditCardPayment(
      BuildContext context, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/payments/stripe'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': 'usd',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Credit card payment successful')),
          );
        }
        return true;
      } else {
        throw Exception(data['message'] ?? 'Credit card payment failed');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Credit card payment failed: [${e.toString()}')),
        );
      }
      return false;
    }
  }

  static Future<bool> _processWalletPayment(
      BuildContext context, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/payments/wallet'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Wallet payment successful')),
          );
        }
        return true;
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(data['message'] ?? 'Insufficient wallet balance')),
          );
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Wallet payment failed: [${e.toString()}')),
        );
      }
      return false;
    }
  }

  static Future<bool> _processPayPalPayment(
      BuildContext context, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('$_backendUrl/payments/paypal'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'currency': 'usd',
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PayPal payment successful')),
          );
        }
        return true;
      } else {
        throw Exception(data['message'] ?? 'PayPal payment failed');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PayPal payment failed: [${e.toString()}')),
        );
      }
      return false;
    }
  }
}
