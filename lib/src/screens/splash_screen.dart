import 'package:flutter/material.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/models/item.dart';
import 'package:grid_test/src/widgets/item_grid_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  // List<Item> items = <Item>[
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
  //   Item('Lead', '${assetImagePath}Frame.png'),
  //   Item('Followup', '${assetImagePath}Frame.png'),
  //   Item('Enquiries', '${assetImagePath}Frame.png'),
  //   Item('Enquiry Ticket', '${assetImagePath}Frame.png')
  // ];
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Marketing'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              hp.goBack();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              onPressed: () {
                hp.goTo('/list');
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      // body: ItemGridWidget(items: items),
      body: Stack(children: [
        Container(
          height: hp.height / 8,
          decoration: BoxDecoration(
              color: hp.theme.primaryColor,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(hp.radius / 25))),
        ),
        // ItemGridWidget(items: items)
      ]),
    );
  }
}
