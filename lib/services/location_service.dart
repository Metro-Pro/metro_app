// import 'package:geolocator/geolocator.dart';
// import 'package:metro_app/models/station.dart';

// class LocationService {
//   static Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     return await Geolocator.getCurrentPosition();
//   }

//   static Station findNearestStation(
//       Position currentPosition, List<Station> stations) {
//     Station nearestStation = stations[0];
//     double shortestDistance = Geolocator.distanceBetween(
//       currentPosition.latitude,
//       currentPosition.longitude,
//       stations[0].latitude,
//       stations[0].longitude,
//     );

//     for (var station in stations) {
//       double distance = Geolocator.distanceBetween(
//         currentPosition.latitude,
//         currentPosition.longitude,
//         station.latitude,
//         station.longitude,
//       );

//       if (distance < shortestDistance) {
//         shortestDistance = distance;
//         nearestStation = station;
//       }
//     }

//     return nearestStation;
//   }
// }
