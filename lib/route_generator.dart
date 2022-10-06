import 'package:grid_test/src/helpers/helper.dart';

import 'src/screens/ar_screen.dart';
import 'src/screens/map_screen.dart';
import 'src/screens/table_screen.dart';
import 'src/screens/item_list_page.dart';
import 'src/screens/grid_page.dart';
import 'src/screens/first_page.dart';
import 'package:flutter/material.dart';
import 'src/screens/qr_scan_screen.dart';
import 'src/screens/flow_menu_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    Widget pageBuilder(BuildContext context) {
      // final args = settings.arguments;
      log(settings.name);
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
        case '/home':
          return const HomeScreen();
        case '/items':
          return const ItemListPage();
        default:
          return const FlowScreen();
      }
    }

    return MaterialPageRoute(builder: pageBuilder, settings: settings);
  }
}
