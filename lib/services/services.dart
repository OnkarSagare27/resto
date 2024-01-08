import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resto/models/location_model.dart';
import 'package:http/http.dart' as http;

// Fetch current location

Future<LocationModel> getCurrentLocation() async {
  String city;
  String subloc;

  try {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
    ].request();
    statuses.forEach(
      (permission, status) {
        if (status == PermissionStatus.denied) {
          openAppSettings();
        } else if (status == PermissionStatus.granted) {}
      },
    );
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      subloc = placemark.subLocality != null ? placemark.subLocality! : '';
      city = placemark.locality != null ? placemark.locality! : '';

      return LocationModel(
        city: city,
        subloc: subloc,
        lat: position.latitude,
        lon: position.longitude,
      );
    }
    throw Exception('Location not found.');
  } catch (e) {
    throw Exception('Location not found.');
  }
}

Future<List<dynamic>> getRestaurants(double lat, double lng) async {
  const String baseUrl = "https://theoptimiz.com/restro/public/api/";
  const String endpoint = "get_resturants";
  const String apiUrl = "$baseUrl$endpoint";

  final requestBody = {
    "lat": lat,
    "lng": lng,
  };

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(requestBody),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(response.body)['data'];
      return responseBody;
    } else {
      throw Exception("Failed to load data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
