import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/di/di.dart';

class Authmanager {
  static final ValueNotifier<String?> authchangenotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPreferences = locator.get();
  static void savetoken(String token) async {
    _sharedPreferences.setString('access_token', token);
    authchangenotifier.value = token;
  }

  static String readAuth() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  static void logOut() {
    _sharedPreferences.clear();
    authchangenotifier.value = null;
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
