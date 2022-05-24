import 'dart:convert';
import '../helpers/helper.dart';
import '../models/schema_row.dart';
import '../models/schema_cell.dart';
import '../models/table_column.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TableData extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final BuildContext context;
  TableData({required this.data, required this.context}) : super();
  List<Map<String, dynamic>> selectedItems = <Map<String, dynamic>>[];
  Helper get hp => Helper.of(context);

  factory TableData.fromString(String e, BuildContext context) =>
      TableData.fromIterable(jsonDecode(e), context);

  factory TableData.fromIterable(
          Iterable<dynamic> elements, BuildContext context) =>
      TableData(
          data: List<Map<String, dynamic>>.from(elements), context: context);

  TableColumn mapKeyToColumn(String e) => TableColumn(columnName: e);

  List<TableColumn> get columns {
    List<String> mapKeys = <String>[];
    for (Map<String, dynamic> item in data) {
      if (item.isEmpty) {
        continue;
      } else {
        for (String key in item.keys) {
          if (!mapKeys.contains(key)) {
            mapKeys.add(key);
          } else {
            continue;
          }
        }
      }
    }
    return mapKeys.map<TableColumn>(mapKeyToColumn).toList();
  }

  List<SchemaRow> get rows {
    List<SchemaRow> drs = <SchemaRow>[];
    for (int i = 0; i < rowCount; i++) {
      final row = getRow(i);
      drs.add(row);
    }
    return drs;
  }

  @override
  SchemaRow getRow(int index) {
    // TODO: implement getRow
    try {
      final val = data[index];
      final flag = ((index + 1) % 2) == 0;
      SchemaCell mapCell(String e) {
        void onTapCell() async {
          if (val[e].toString().contains('http')) {
            final p = await launch(val[e].toString());
            if (p) {
              log(val[e]);
            }
          }
        }

        return SchemaCell(
            cellData: MouseRegion(
                cursor: val[e].toString().contains('http')
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.text,
                child: GestureDetector(
                    onTap: onTapCell,
                    child: SelectableText(
                        val[e] is String ? val[e] : val[e].toString(),
                        style: TextStyle(
                            decoration: val[e].toString().contains('http')
                                ? TextDecoration.underline
                                : null)))));
      }

      void onPickedChanged(bool? value) {
        void selectOrUnselectRow() {
          // selectedItems[index] = value ?? false;
          notifyListeners();
        }

        try {
          selectOrUnselectRow();
        } catch (e) {
          rethrow;
        }
      }

      return SchemaRow(
          onPickChanged: onPickedChanged,
          // isSelected: selectedItems[index],
          rowColor: Color(int.parse('0xff${flag ? 'f4f4f4' : 'ffffff'}')),
          items: val.keys.map<SchemaCell>(mapCell).toList());
    } catch (e) {
      rethrow;
    }
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => selectedItems.length;
}
