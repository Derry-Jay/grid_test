import 'collection_cell.dart';
import 'package:flutter/material.dart';

class CollectionRow extends TableRow {
  final List<CollectionCell> cells;
  Widget mapCell(CollectionCell e) => e.cellData;
  CollectionRow({required this.cells, LocalKey? key})
      : super(key: key, children: cells.map<Widget>((CollectionCell e) => e.cellData).toList());
}
