import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:grid_test/route_generator.dart';
import 'package:grid_test/src/widgets/empty_widget.dart';
import 'generated/l10n.dart';
import 'src/backend/api.dart';
import 'src/helpers/helper.dart';
import 'src/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'src/models/scope_model_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  try {
    wb = WidgetsFlutterBinding.ensureInitialized();
    gc = await GlobalConfiguration().loadFromAsset('configurations');
    if (!(wb?.buildOwner?.debugBuilding ?? true)) {
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
    final hpa = Helper.of(context);
    Widget rootBuilder(
        BuildContext context, AsyncSnapshot<ConnectivityResult> result) {
      final hpr = Helper.of(context);
      if (result.connectionState == ConnectionState.active ||
          result.connectionState == ConnectionState.done) {
        hpr.getConnectStatus();
      }
      return result.hasData &&
              !result.hasError &&
              result.data != ConnectivityResult.none
          ? MyHomePage(model: model)
          : const Scaffold(body: EmptyWidget());
    }

    return MaterialApp(
        title: 'Flutter Demo',
        locale: model.appLocal,
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: RouteGenerator().generateRoute,
        home: StreamBuilder<ConnectivityResult>(
            builder: rootBuilder, stream: hpa.con.onConnectivityChanged),
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
            primarySwatch: Colors.blue,
            secondaryHeaderColor: Colors.black,
            scaffoldBackgroundColor: Colors.white),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(builder: appBuilder));
  }
}
