import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  int _counter = 0;
  late BuildContext buildContext;
  int get counter => _counter;
  MyModel({required BuildContext context}) {
    buildContext = context;
  }

  set counter(int value) {
    if (value != _counter) {
      _counter = value;
      notifyListeners();
    }
  }
}
