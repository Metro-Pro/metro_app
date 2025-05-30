import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:metro_app/models/station.dart';

class StationDialog extends StatelessWidget {
  final Station station;
  final VoidCallback onClose;
  final Function(LatLng) onOpenInGoogleMaps;

  const StationDialog({
    super.key,
    required this.station,
    required this.onClose,
    required this.onOpenInGoogleMaps,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      left: 16,
      right: 16,
      child: Card(
        elevation: 12,
        shadowColor: Colors.black.withAlpha((.3 * 255).toInt()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[900]!,
                Colors.grey[850]!,
              ],
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _getLineColor(station.lineNumber),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _getLineColor(station.lineNumber)
                              .withAlpha((255 * 0.3).toInt()),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        station.lineNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      station.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                    color: Colors.grey[400],
                    iconSize: 24,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          _getLineColor(station.lineNumber),
                          _getLineColor(station.lineNumber)
                              .withAlpha((255 * 0.8).toInt()),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _getLineColor(station.lineNumber)
                              .withAlpha((255 * 0.3).toInt()),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => onOpenInGoogleMaps(station.location),
                      icon: const Icon(Icons.map, size: 20),
                      label: const Text(
                        'Open in Google Maps',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getLineColor(String lineNumber) {
    switch (lineNumber) {
      case '1':
        return const Color(0xFFE53935); // Vibrant Red
      case '2':
        return const Color(0xFF1E88E5); // Vibrant Blue
      case '3':
        return const Color(0xFF43A047); // Vibrant Green
      default:
        return const Color(0xFF757575); // Grey
    }
  }
}
