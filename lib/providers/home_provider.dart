import 'package:flutter/material.dart';
import 'package:resto/models/location_model.dart';
import 'package:resto/services/services.dart';

// Custom provider for state management

class HomeProvider extends ChangeNotifier {
  LocationModel? _currentLocationModel;
  LocationModel? get currentLocationModel => _currentLocationModel;

  Map<String, dynamic>? _currentRestos;
  Map<String, dynamic>? get currentRestos => _currentRestos;

  int _currentTabInd = 1;
  int get currentTabInd => _currentTabInd;

  PageController homePageTagController = PageController();

  // Fetch current location

  Future<void> getCurrentLocationDetails() async {
    LocationModel currentLocationModelTmp = await getCurrentLocation();
    _currentLocationModel = currentLocationModelTmp;
    await getCurrentLocationRestos();
    notifyListeners();
  }

  // Fetch current locations restaurants

  Future<void> getCurrentLocationRestos() async {
    Map<String, dynamic> currentRestosTmp = await getRestaurants(
        _currentLocationModel!.lat, _currentLocationModel!.lon);
    _currentRestos = currentRestosTmp;
  }

  void setCurrentTabInd(int index) {
    _currentTabInd = index;
    notifyListeners();
  }
}
