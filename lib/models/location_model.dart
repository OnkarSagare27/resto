class LocationModel {
  final String city;
  final String? subloc;

  final double lat;
  final double lon;

  LocationModel({
    required this.city,
    required this.subloc,
    required this.lat,
    required this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": city,
      "state": subloc,
      "lat": lat,
      "lon": lon,
    };
  }
}
