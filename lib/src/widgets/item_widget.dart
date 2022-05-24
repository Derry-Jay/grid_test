import 'dart:math';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final MediaQueryData dimensions;
  Size get size => dimensions.size;
  double get height => size.height;
  double get width => size.width;
  double get radius => sqrt(pow(width, 2) + pow(height, 2));
  const ItemWidget({Key? key, required this.dimensions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Card(
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.all(Radius.circular(radius / 160))),
    //   child: Padding(
    //       padding: EdgeInsets.symmetric(
    //           vertical: height / 40, horizontal: width / 32),
    //       child: Column(
    //         children: [
    //           Padding(
    //               padding: EdgeInsets.only(bottom: height / 50),
    //               child: Row(children: [
    //                 Text(item.name),
    //                 IconButton(
    //                     onPressed: () {},
    //                     icon: Icon(Icons.arrow_forward_ios_sharp, size: 50))
    //               ], mainAxisAlignment: MainAxisAlignment.spaceBetween)),
    //           Row(
    //             children: [
    //               Text(item.date),
    //               Text(item.amount),
    //               Text(item.cate + " " + item.type)
    //             ],
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           )
    //         ],
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //       )),
    // );
    return const SizedBox();
  }
}
