import '../models/item.dart';
import '../helpers/helper.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  const ItemWidget({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final hp = Helper.of(context);
    return Column(
      children: [
        Container(
            height: hp.height / 6.4,
            width: hp.width / 3.2,
            decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.32),
                borderRadius:
                    BorderRadius.all(Radius.circular(hp.radius / 100))),
            padding: EdgeInsets.all(hp.radius / 400),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: hp.theme.primaryColor, width: 2),
                    borderRadius:
                        BorderRadius.all(Radius.circular(hp.radius / 100)),
                    image: DecorationImage(
                        image: AssetImage(item.image), fit: BoxFit.contain)))),
        Text(item.content)
      ],
    );
  }
}
