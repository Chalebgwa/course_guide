import 'package:flutter/material.dart';

class NavController extends ChangeNotifier {

  String currentRoute = 'Home';

  void changeRoute(String route) {
    currentRoute = route;
    notifyListeners();
  }
  
}