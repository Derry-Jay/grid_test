import 'package:flutter/material.dart';
import 'package:grid_test/src/helpers/helper.dart';

import '../models/item.dart';
import '../widgets/item_grid_widget.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  List<Item> items = <Item>[
    Item('Lead', '${assetImagePath}Frame.png'),
    Item('Followup', '${assetImagePath}Frame.png'),
    Item('Enquiries', '${assetImagePath}Frame.png'),
    Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
    Item('Lead', '${assetImagePath}Frame.png'),
    Item('Followup', '${assetImagePath}Frame.png'),
    Item('Enquiries', '${assetImagePath}Frame.png'),
    Item('Enquiry Ticket', '${assetImagePath}Frame.png'),
    Item('Lead', '${assetImagePath}Frame.png'),
    Item('Followup', '${assetImagePath}Frame.png'),
    Item('Enquiries', '${assetImagePath}Frame.png'),
    Item('Enquiry Ticket', '${assetImagePath}Frame.png')
  ];
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
            height: hp.height / 20,
            width: hp.width / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(hp.radius / 80)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('${assetImagePath}download.jpeg')))),
        // centerTitle: true,
        // leading: ,
        actions: [
          IconButton(
              onPressed: () {
                hp.goTo('/home');
              },
              icon: const Icon(Icons.notifications))
        ],
      ),
      // body: ItemGridWidget(items: items),
      body: Stack(children: [
        Container(
            height: hp.height / 8,
            width: double.infinity,
            padding: EdgeInsets.only(left: hp.width / 32),
            decoration: BoxDecoration(
                color: hp.theme.primaryColor,
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(hp.radius / 25))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Good Morning, Bala !',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                Text('16 sep,2022', style: TextStyle(color: Colors.white))
              ],
            )),
        ItemGridWidget(items: items)
      ]),
    );
  }
}
