// import 'package:grid_test/src/screens/table_screen.dart';

import 'generated/l10n.dart';
import 'src/backend/api.dart';
import 'src/helpers/helper.dart';
import 'src/screens/empty_screen.dart';
import 'src/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'src/widgets/circular_loader.dart';
import 'src/models/scope_model_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'dart:ffi';
// import 'dart:io';
//
// import 'package:sqlite3/open.dart';
// import 'package:sqlite3/sqlite3.dart';

void main() async {
  try {
    wb = WidgetsFlutterBinding.ensureInitialized();
    gc = await GlobalConfiguration().loadFromAsset('configurations');
    if (wb?.buildOwner?.debugBuilding ?? true) {
      throw Exception();
    } else {
      //     final db = sqlite3.openInMemory();
      //     db.execute('''
      //   CREATE TABLE IF NOT EXISTS users (
      //     id INTEGER NOT NULL AUTO INCREMENT PRIMARY KEY,
      //     name TEXT NOT NULL,
      //     email TEXT NOT NULL,
      //     mobile TEXT NOT NULL,
      //     gender TEXT NOT NULL,
      //     token TEXT UNIQUE
      //   );
      // ''');
      getGPSPermission();
      log('####################');
      log(gc?.getValue('page') == gc?.getValue('total'));
      log(gc?.getValue('records'));
      log('@@@@@@@@@@@@@@');
      runApp(const MyApp());
    }
  } catch (e) {
    log(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget appBuilder(BuildContext context, Widget? child, AppModel model) {
    // final hpa = Helper.of(context);
    Widget rootBuilder(
        BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
      final hpr = Helper.of(context);
      try {
        switch (result.connectionState) {
          case ConnectionState.active:
          case ConnectionState.done:
            if (result.hasData && !result.hasError) {
              switch (result.data) {
                case ConnectivityResult.none:
                  hpr.getConnectStatus();
                  return const EmptyScreen();
                // default:
                //   return const IntroScreen();
                default:
                  return MyHomePage(model: model);
              }
            } else {
              return const EmptyScreen();
            }
          case ConnectionState.none:
            return const EmptyScreen();
          default:
            return Scaffold(
                body: CircularLoader(
                    color: hpr.theme.primaryColor,
                    duration: const Duration(seconds: 10)));
        }
      } catch (e) {
        log(e);
        return const EmptyScreen();
      }
    }

    return MaterialApp(
        title: 'Flutter Demo',
        locale: model.appLocal,
        // home: const EmptyScreen(),
        onGenerateRoute: rg.generateRoute,
        debugShowCheckedModeBanner: kDebugMode,
        supportedLocales: S.delegate.supportedLocales,
        home: StreamBuilder<ConnectivityResult>(
            builder: rootBuilder, stream: conn.onConnectivityChanged),
        localizationsDelegates: const [
          S.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            hintColor: Colors.grey,
            primarySwatch: Colors.teal,
            secondaryHeaderColor: Colors.black,
            scaffoldBackgroundColor: Colors.white));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(builder: appBuilder));
  }
}
