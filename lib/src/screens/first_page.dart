import '../backend/api.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';
import '../widgets/some_item_list_widget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  Helper get hp => Helper.of(context);
  Widget valueBuilder(BuildContext context, AsyncSnapshot<int> value) {
    return Text(value.data.toString());
  }

  @override
  Widget build(BuildContext context) {
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
        //   // ,TextFormField(
        //   //     controller: con.nc,
        //   //     validator: hp.nameValidator,
        //   //     decoration: InputDecoration(
        //   //         contentPadding: EdgeInsets.symmetric(
        //   //             vertical: hp.height / 100, horizontal: hp.width / 40),
        //   //         border: const OutlineInputBorder(),
        //   //         hintText: hp.loc.full_name)),
        //   // TextFormField(
        //   //     controller: con.dc,
        //   //     validator: hp.descriptionValidator,
        //   //     decoration: InputDecoration(
        //   //         contentPadding: EdgeInsets.symmetric(
        //   //             vertical: hp.height / 100, horizontal: hp.width / 40),
        //   //         border: const OutlineInputBorder(),
        //   //         hintText: hp.loc.description))
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
                  const Expanded(flex: 2, child: SomeItemListWidget()),
                  Flexible(
                      flex: 2,
                      child: StreamBuilder<int>(
                          builder: valueBuilder,
                          stream: getValues(2),
                          initialData: 0))
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Container(
                  //         width: 225.0,
                  //         height: 60.0,
                  //         color: hp.theme.dividerColor,
                  //         padding: const EdgeInsets.only(
                  //             top: 20, bottom: 15, left: 25, right: 20),
                  //         child: Text('Delivery Date',
                  //             style: TextStyle(
                  //                 color: hp.theme.secondaryHeaderColor,
                  //                 fontSize: 20)),
                  //       ),
                  //       Container(
                  //         width: 225.0,
                  //         height: 60.0,
                  //         color: hp.theme.dividerColor,
                  //         padding: const EdgeInsets.only(
                  //             top: 20, bottom: 15, left: 25, right: 20),
                  //         child: Text('Delivery ID',
                  //             style: TextStyle(
                  //                 color: hp.theme.secondaryHeaderColor,
                  //                 fontSize: 20)),
                  //       ),
                  //       Container(
                  //         width: 225.0,
                  //         height: 60.0,
                  //         color: hp.theme.dividerColor,
                  //         padding: const EdgeInsets.only(
                  //             top: 20, bottom: 15, left: 25, right: 20),
                  //         child: Text('Customer',
                  //             style: TextStyle(
                  //                 color: hp.theme.secondaryHeaderColor,
                  //                 fontSize: 20)),
                  //       ),
                  //     ],
                  //   ),
                ],
              ))),
      bottomNavigationBar: SizedBox(width: hp.width, height: 50),
    );
  }
}
