import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:metro_app/models/ticket.dart';
import 'package:intl/intl.dart';

class TicketQRCode extends StatefulWidget {
  final Ticket ticket;

  const TicketQRCode({
    super.key,
    required this.ticket,
  });

  @override
  State<TicketQRCode> createState() => _TicketQRCodeState();
}

class _TicketQRCodeState extends State<TicketQRCode> {
  late Timer _timer;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _checkExpiration();
    // Update expiration status every minute
    _timer =
        Timer.periodic(const Duration(minutes: 1), (_) => _checkExpiration());
  }

  void _checkExpiration() {
    setState(() {
      _isExpired = DateTime.now().isAfter(widget.ticket.validUntil);
    });
  }

  String _getQRData() {
    return '''
      Ticket ID: ${widget.ticket.id}
      Type: ${widget.ticket.ticketType}
      Valid From: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.ticket.validFrom)}
      Valid Until: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.ticket.validUntil)}
      ${widget.ticket.sourceStation != null ? 'From: ${widget.ticket.sourceStation}' : ''}
      ${widget.ticket.destinationStation != null ? 'To: ${widget.ticket.destinationStation}' : ''}
    ''';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              if (_isExpired)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'EXPIRED',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              QrImageView(
                data: _getQRData(),
                version: QrVersions.auto,
                size: 200.0,
                backgroundColor: Colors.white,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
              ),
              const SizedBox(height: 16),
              Text(
                'Valid until: ${DateFormat('yyyy-MM-dd HH:mm').format(widget.ticket.validUntil)}',
                style: TextStyle(
                  color: _isExpired ? Colors.red : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
