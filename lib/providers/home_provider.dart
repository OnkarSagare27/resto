import 'package:flutter/material.dart';
import 'package:resto/models/location_model.dart';
import 'package:resto/services/services.dart';

// Custom provider for state management

class HomeProvider extends ChangeNotifier {
  LocationModel? _currentLocationModel;
  LocationModel? get currentLocationModel => _currentLocationModel;

  List<dynamic>? _currentRestos;
  List<dynamic>? get currentRestos => _currentRestos;
  List<dynamic>? _allRestos;
  List<dynamic>? get allRestos => _allRestos;

  int _currentTabInd = 1;
  int get currentTabInd => _currentTabInd;

  int _currentScreenInd = 0;
  int get currentScreenInd => _currentScreenInd;

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
    List<dynamic> currentRestosTmp = await getRestaurants(
        _currentLocationModel!.lat, _currentLocationModel!.lon);

    _currentRestos = currentRestosTmp;
    _allRestos = currentRestosTmp;
  }

  void setCurrentTabInd(int index) {
    _currentTabInd = index;
    notifyListeners();
  }

  void setCurrentScreenInd(int index) {
    _currentScreenInd = index;
    notifyListeners();
  }

  void filterRestos(String value) {
    if (value.isEmpty) {
      _currentRestos = _allRestos;
      notifyListeners();
    } else {
      _currentRestos = _allRestos!
          .where((restaurant) => restaurant['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
