import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlatformChangeProvider extends ChangeNotifier {
  bool isIos = false;
  SharedPreferences? sharedPreferences;

  void toggleBetweenPlatforms() {
    isIos = !isIos;
    setPlatform(isIos);
    notifyListeners();
  }

  Future<void> setPlatform(bool value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool("platform", value);
  }

  PlatformChangeProvider(bool value){
    isIos = value;
  }
}