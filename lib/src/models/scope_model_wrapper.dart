import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  Locale _appLocale = const Locale('en');
  Locale get appLocal => _appLocale;

  void changeDirection() {
    if (_appLocale == const Locale('en')) {
      _appLocale = const Locale('fr');
    } else if (_appLocale == const Locale('fr')) {
      _appLocale = const Locale('ar');
    } else {
      _appLocale = const Locale('en');
    }
    notifyListeners();
  }
}
