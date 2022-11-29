import 'package:grid_test/src/models/county.dart';
import 'package:grid_test/src/models/route_argument.dart';
import 'package:grid_test/src/screens/state_based_cities_screen.dart';
import 'package:grid_test/src/screens/states_screen.dart';

import 'src/screens/products_page.dart';

import 'src/helpers/helper.dart';
import 'src/screens/grid_page.dart';
import 'src/screens/ar_screen.dart';
import 'src/screens/first_page.dart';
import 'src/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'src/screens/table_screen.dart';
import 'src/screens/qr_scan_screen.dart';
import 'src/screens/product_details_screen.dart';
import 'src/screens/flow_menu_screen.dart';

class RouteGenerator {
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final arguments = settings.arguments as RouteArgument?;
    Widget pageBuilder(BuildContext context) {
      // final hp = Helper.of(context);
      log(settings.name);
      switch (settings.name) {
        case '/qr':
          return const QRScanScreen();
        case '/states':
          return const StatesScreen();
        case '/cities':
          return StateBasedCitiesScreen(rar: args as RouteArgument);
        case '/first':
          return const FirstPage();
        case '/grid':
          return const GridPage();
        case '/ar':
          return const ARScreen();
        case '/map':
          return const MapScreen();
        case '/intro':
          return const IntroScreen();
        case '/productInfo':
          return ProductDetailsScreen(rar: args as RouteArgument? ?? RouteArgument());
        case '/products':
          return const ProductsPage();
        default:
          return const FlowScreen();
      }
    }

    Widget screenBuilder(
        BuildContext context, Animation<double> a1, Animation<double> a2) {
      Widget contentBuilder(BuildContext context, Widget? child) {
        Widget psBuilder(BuildContext context, Widget? child) {
          return child ?? pageBuilder(context);
        }

        return child ?? AnimatedBuilder(animation: a2, builder: psBuilder);
      }

      return AnimatedBuilder(animation: a1, builder: contentBuilder);
    }

    switch (arguments?.type) {
      case TransitionType.decorative:
        return PageRouteBuilder(pageBuilder: screenBuilder, settings: settings);
      default:
        return MaterialPageRoute(builder: pageBuilder, settings: settings);
    }
  }
}
