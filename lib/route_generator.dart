import 'package:grid_test/src/screens/ar_screen.dart';
import 'package:grid_test/src/screens/map_screen.dart';

import 'src/screens/grid_page.dart';
import 'src/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'src/screens/qr_scan_screen.dart';
import 'src/screens/flow_menu_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Widget pageBuilder(BuildContext context) {
      // final args = settings.arguments;
      switch (settings.name) {
        case '/qr':
          return const QRScanScreen();
        case '/first':
          return const FirstPage();
        case '/grid':
          return const GridPage();
        case '/ar':
          return const ARScreen();
        case '/map':
          return const MapScreen();
        default:
          return const FlowScreen();
      }
    }

    return MaterialPageRoute(builder: pageBuilder, settings: settings);
  }
}
