import 'schema_cell.dart';
import 'package:flutter/material.dart';

class SchemaRow extends DataRow {
  final List<SchemaCell> items;
  final Color? rowColor;
  final bool? isSelected;
  final void Function(bool?)? onPickChanged;
  SchemaRow(
      {required this.items, this.rowColor, this.isSelected, this.onPickChanged})
      : super(
            cells: items,
            selected: isSelected ?? false,
            onSelectChanged: onPickChanged,
            color: MaterialStateProperty.all<Color?>(rowColor));
}
