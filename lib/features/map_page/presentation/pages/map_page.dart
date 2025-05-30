import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong2/latlong.dart';
import 'package:metro_app/features/map_page/presentation/utils/map_utils.dart';
import 'package:metro_app/features/map_page/presentation/widgets/zoom_button.dart';
import 'package:metro_app/models/station.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

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

  List<LatLng> line1Points = [];

  List<LatLng> line2Points = [];
  List<LatLng> line3Points = [];

  List<Station> stations = [];
  @override
  void initState() {
    super.initState();
    _loadStations();
    _loadPoints();
  }

  Future<void> _loadStations() async {
    final loadedStations = await MapUtils.getStations();
    setState(() {
      stations = loadedStations;
    });
  }

  void _loadPoints() async {
    line1Points = await MapUtils.getStationsByLine('1')
        .then((value) => value.map((e) => e.location).toList());
    line2Points = await MapUtils.getStationsByLine('2')
        .then((value) => value.map((e) => e.location).toList());
    line3Points = await MapUtils.getStationsByLine('3')
        .then((value) => value.map((e) => e.location).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(29.93, 31.2),
              initialZoom: 10.2,
              interactionOptions: InteractionOptions(
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
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                      .toList()),
            ],
          ),
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
        ],
      ),
    );
  }
}
