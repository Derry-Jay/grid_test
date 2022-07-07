import 'package:flutter/material.dart';
import 'package:grid_test/src/helpers/helper.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  ItemListPageState createState() => ItemListPageState();
}

class ItemListPageState extends State<ItemListPage> {
  Helper get hp => Helper.of(context);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: hp.width / 80),
              width: hp.width,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius:
                      BorderRadius.all(Radius.circular(hp.radius / 160))),
              padding: EdgeInsets.symmetric(
                  horizontal: hp.width / 50, vertical: hp.height / 80),
              child: const Text('Task 3'),
            ),
            // Expanded(
            //     child: ItemListWidget(
            //         items: ItemBase.fromMap().items, dimensions: hp.dimensions)),

// firstTimeinitFlag
//             ?
//             // FutureBuilder<PalletLocationModel>(
            //     future: api.palletLocations(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         PalletLocationModel? deliveryData = snapshot.data;
            //         return

            //   } else {
            // return ;
            //   }
            // })
            // : FutureBuilder<Getpalletlocationsmodel>(
            //     future: api.getPalletLocations(pallerdropdownvalue?.id ?? 0,
            //         zonedropdownvalue?.id ?? 0, rackdropdownvalue?.id ?? 0),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData) {
            //         Getpalletlocationsmodel? deliveryData = snapshot.data;
            //         return ListView.builder(
            //           scrollDirection: Axis.vertical,
            //           shrinkWrap: true,
            //           physics: BouncingScrollPhysics(
            //               parent: deliveryData!
            //                           .palletLocations.getLocations.length <=
            //                       10
            //                   ? const NeverScrollableScrollPhysics()
            //                   : const AlwaysScrollableScrollPhysics()),
            //           itemBuilder: (context, index) {
            //             final item =
            //                 deliveryData.palletLocations.getLocations[index];
            //             // log('Hi');
            //             // log(item.status);
            //             // log('Bye');
            //             return Container(
            //               margin: const EdgeInsets.only(top: 1),
            //               padding: const EdgeInsets.all(15),
            //               alignment: Alignment.topLeft,
            //               height: 50,
            //               color: hp.parseBool(deliveryData
            //                       .palletLocations.getLocations[index].status)
            //                   ? hp.theme.splashColor
            //                   : hp.theme.toggleableActiveColor,
            //               child: Text(
            //                 deliveryData.palletLocations.getLocations[index]
            //                         .uniqueId ??
            //                     '',
            //                 textAlign: TextAlign.center,
            //                 style: const TextStyle(
            //                     fontSize: 17, color: Colors.white),
            //               ),
            //             );
            //           },
            //           itemCount:
            //               deliveryData.palletLocations.getLocations.length,
            //         );
            //       } else {
            //         return Image.asset(
            //             gc.getValue('asset_image_path') + 'puzzle_128.gif');
            //       }
            //     }),
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: const Center(
                child: Text('Note: Date Shown is Trxn Date'),
              ),
            )
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          title: Row(
            children: const [
              Expanded(child: Text('Trxn Date')),
              Expanded(child: Text('Amt'))
            ],
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(top: hp.height / 25.6),
                child: const Text('Type/Mode',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
          ],
        ));
  }
}
