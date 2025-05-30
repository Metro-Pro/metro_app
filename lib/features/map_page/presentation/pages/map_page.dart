// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:metro_app/features/map_page/presentation/utils/map_utils.dart';
import 'package:metro_app/features/map_page/presentation/widgets/station_dialog.dart';
import 'package:metro_app/features/map_page/presentation/widgets/zoom_button.dart';
import 'package:metro_app/models/station.dart';

class MapPage extends StatefulWidget {
  LatLng initialLocation;
  double initialZoom;
  bool showControls;
  MapPage({
    super.key,
    this.initialLocation = const LatLng(29.93, 31.2),
    this.initialZoom = 10.2,
    this.showControls = true,
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();
  bool _isLoading = true;
  Station? _selectedStation;

  void _zoomIn() {
    _mapController.move(
      _mapController.camera.center,
      _mapController.camera.zoom + 1,
    );
  }

  void _zoomOut() {
    _mapController.move(
      _mapController.camera.center,
      _mapController.camera.zoom - 1,
    );
  }

  Future<void> _handleOpenInGoogleMaps(LatLng location) async {
    final success = await MapUtils.openInGoogleMaps(location);
    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not open Google Maps'),
        ),
      );
    }
  }

  List<LatLng> line1Points = [];
  List<LatLng> line2Points = [];
  List<LatLng> line3Points = [];

  List<Station> line1 = [];
  List<Station> line2 = [];
  List<Station> line3 = [];

  List<Station> stations = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      // Load all stations first
      final loadedStations = await MapUtils.getStations();

      // Load stations by line
      line1 = await MapUtils.getStationsByLine('1');
      line2 = await MapUtils.getStationsByLine('2');
      line3 = await MapUtils.getStationsByLine('3');

      // Convert stations to points
      line1Points = line1.map((station) => station.location).toList();
      line2Points = line2.map((station) => station.location).toList();
      line3Points = line3.map((station) => station.location).toList();

      if (mounted) {
        setState(() {
          stations = loadedStations;
          _isLoading = false;
        });
      }
    } catch (e) {
      log('Error loading map data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: widget.initialLocation,
                initialZoom: widget.initialZoom,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: line1Points,
                      color: Colors.red,
                      strokeWidth: 4.0,
                    ),
                    Polyline(
                      points: line2Points,
                      color: Colors.blue,
                      strokeWidth: 4.0,
                    ),
                    Polyline(
                      points: line3Points,
                      color: Colors.green,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
                MarkerLayer(
                  markers: stations
                      .map(
                        (station) => Marker(
                          point: LatLng(station.location.latitude,
                              station.location.longitude),
                          width: 12,
                          height: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedStation = station;
                              });
                            },
                            child: Tooltip(
                              message: station.name,
                              child: Container(
                                alignment: Alignment.center,
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[300],
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Text(
                                  "M",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          if (_selectedStation != null)
            StationDialog(
              station: _selectedStation!,
              onClose: () {
                setState(() {
                  _selectedStation = null;
                });
              },
              onOpenInGoogleMaps: _handleOpenInGoogleMaps,
            ),
          if (widget.showControls ?? true)
            Positioned(
              right: 16,
              bottom: 20,
              child: Column(
                children: [
                  ZoomButton(icon: Icons.add, onPressed: _zoomIn),
                  ZoomButton(
                    icon: Icons.remove,
                    onPressed: _zoomOut,
                  )
                ],
              ),
            ),
          if (widget.showControls ?? true)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
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
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: Colors.black87,
                  iconSize: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
