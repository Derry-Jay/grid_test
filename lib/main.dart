import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grid_test/src/models/scope_model_wrapper.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:grid_test/src/screens/home_page.dart';
import 'package:scoped_model/scoped_model.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/helpers/helper.dart';

void main() async {
  final q = WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  final p = await GlobalConfiguration().loadFromAsset('configurations');
  if (!q.buildOwner!.debugBuilding) {
    log('####################');
    log(p.getValue('asset_image_path'));
    log('@@@@@@@@@@@@@@');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  Widget appBuilder(BuildContext context, Widget? child, AppModel model) => MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // This is the theme of your application.
          // 656567, 4e8ef7, cacacc, 696d75, 32db64, f53d3d, f4f4f4, 222
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to  and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          errorColor: const Color(0xfff53d3d),
          toggleableActiveColor: const Color(0xffeeb134),
          primarySwatch: Colors.blueGrey,
          canvasColor: const Color(0xffcacdde),
          hoverColor: const Color(0xffe2e4ef),
          dividerColor: const Color(0xffdedede),
          scaffoldBackgroundColor: const Color(0xffe5e5e5)),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: model.appLocal,
      home: MyHomePage(model: model));

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(builder: appBuilder));
  }
}
