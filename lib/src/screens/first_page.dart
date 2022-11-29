import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../widgets/todo_list_widget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  Helper get hp => Helper.of(context);
  double turns = 0;

  void turnBuilder() {
    mounted
        ? setState(() {
            turns += (1 / 8);
          })
        : doNothing();
  }

  Widget valueBuilder(BuildContext context, AsyncSnapshot<int> value) {
    return Text(value.data.toString());
  }

  @override
  Widget build(BuildContext context) {
    IconData idt = Icons.flip;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        idt = Icons.flip_camera_android;
        break;
      case TargetPlatform.iOS:
        idt = Icons.flip_camera_ios;
        break;
      default:
        break;
    }
    return Scaffold(
      appBar: AppBar(
        // title: Stack(children: [
        //   Container(
        //       width: 100,
        //       height: 70,
        //       alignment: Alignment.center,
        //       margin: const EdgeInsets.only(left: 60),
        //       decoration: BoxDecoration(
        //           borderRadius: const BorderRadius.only(
        //             bottomRight: Radius.circular(20),
        //             bottomLeft: Radius.circular(20),
        //           ),
        //           border: Border.all(
        //             width: 1,
        //             color: Colors.blueGrey,
        //             style: BorderStyle.solid,
        //           ),
        //           color: Colors.white),
        //       child: Image.asset(
        //         'assets/images/logo.jpg',
        //         fit: BoxFit.scaleDown,
        //         height: 32,
        //       ))
        // ]),
        // title: Image.asset('assets/images/logo.jpg',
        //     fit: BoxFit.fill, height: hp.height / 20),
        actions: [
          IconButton(
              onPressed: hp.goBack,
              icon: const Icon(Icons.notifications),
              tooltip: 'notification'),
          // IconButton(
          //   icon: const CircleAvatar(
          //     backgroundImage: const AssetImage('assets/imgnature.jpg'),
          //   ),
          //   onPressed: CallContact,

          // ),
          IconButton(
              onPressed: () {
                hp.goTo('/grid');
              },
              icon: const Icon(Icons.chat_bubble),
              tooltip: 'chat'),
          // IconButton(
          //     onPressed: hp.doNothing,
          //     icon: Image.asset('assets/images/logout.png'),
          //     tooltip: 'sfsdf'),
        ],
      ),
      // drawer: const Drawer(),
      body: SingleChildScrollView(
          child: SizedBox(
              width: hp.width,
              height: hp.height,
              child: Column(
                children: <Widget>[
                  AnimatedRotation(
                      turns: turns,
                      duration: const Duration(seconds: 1),
                      child: const FlutterLogo()),
                  IconButton(onPressed: turnBuilder, icon: Icon(idt)),
                  Flexible(
                      flex: 2,
                      child: StreamBuilder<int>(
                          builder: valueBuilder,
                          stream: getValues(2),
                          initialData: 0)),
                  // const Expanded(flex: 2, child: SomeItemListWidget())
                ],
              ))),
      bottomNavigationBar: SizedBox(width: hp.width, height: 50),
    );
  }
}
