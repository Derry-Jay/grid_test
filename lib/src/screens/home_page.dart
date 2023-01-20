import '../backend/api.dart';
import '../models/cart.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/scope_model_wrapper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.model}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final AppModel model;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? val, map;
  Helper get hp => Helper.of(context);

  void setData() async {
    // val = await getMap();
    map = await obtainMap();
    mounted ? setState(() {}) : log('unmounted');
  }

  Widget pageBuilder(BuildContext context, MyModel model, Widget? child) {
    return child ??
        Scaffold(
          appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: SelectableText(hp.loc.description, onTap: () async {
                hp.goTo('/qr');
              }),
              actions: [
                IconButton(
                    onPressed: () async {
                      hp.goTo('/first');
                    },
                    icon: const Icon(Icons.arrow_forward_ios))
              ]),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because s are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: const SelectableText(
                    'You have pushed the button this many times:',
                  ),
                  onTap: () async {
                    hp.goTo('/map');
                  },
                ),
                SelectableText('${model.counter}',
                    style: hp.textTheme.headline4, onTap: () async {
                  hp.goTo('/home');
                }),
                ElevatedButton(
                    onPressed: () async {
                      widget.model.changeDirection();
                    },
                    child: Text(hp.loc.details)),
                SelectableText(hp.loc.you_must_signin_to_access_to_this_section,
                    onTap: () async {
                  log(val);
                  log(map);
                }),
                ElevatedButton(
                    onPressed: () async {
                      hp.goTo('/ar');
                    },
                    child: const Text('ARKit'))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            onPressed: () => model.counter++,
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
        child: ChangeNotifierProvider<MyModel>(
            create: (BuildContext context) {
              return MyModel(context: context);
            },
            child: Consumer<MyModel>(builder: pageBuilder)));
  }
}
