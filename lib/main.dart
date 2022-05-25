import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/backend/api.dart';
import 'src/helpers/helper.dart';
import 'src/models/scope_model_wrapper.dart';
import 'src/screens/home_page.dart';

void main() async {
  try {
    wb = WidgetsFlutterBinding.ensureInitialized();
    gc = await GlobalConfiguration().loadFromAsset('configurations');
    if (!wb!.buildOwner!.debugBuilding && gc != null) {
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => MaterialApp(
                title: 'Flutter Demo',
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
                  primarySwatch: Colors.blue,
                ),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: model.appLocal,
                home: MyHomePage(model: model))));
  }
}
