import 'package:flutter/material.dart';

class CollectionCell extends TableCell {
  final Widget cellData;
  const CollectionCell({Key? key, required this.cellData})
      : super(key: key, child: cellData);
}
