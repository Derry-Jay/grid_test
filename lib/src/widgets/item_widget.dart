import '../model/item.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final hp = Helper.of(context);
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(hp.radius / 160))),
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: hp.height / 40, horizontal: hp.width / 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: hp.height / 50),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.name),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_ios_sharp,
                                size: 50))
                      ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(item.date),
                  Text(item.amount),
                  Text('${item.cate} ${item.type}')
                ],
              )
            ],
          )),
    );
  }
}
