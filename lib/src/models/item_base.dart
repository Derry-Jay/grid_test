import 'package:global_configuration/global_configuration.dart';

import 'item.dart';

class ItemBase {
  final gc = GlobalConfiguration();
  late int page, total, recordCount;
  late List<Item> items;
  ItemBase();
  ItemBase.fromMap() {
    try {
      page = gc.getValue('page');
      total = gc.getValue('total');
      recordCount = int.tryParse(gc.getValue('records').toString()) ?? 0;
      items = gc.getValue('rows') == null
          ? <Item>[]
          : List<Map<String, dynamic>>.from(gc.getValue('rows'))
              .map((e) => Item.fromMap(e))
              .toList();
    } catch (e) {
      page = 0;
      total = 0;
      recordCount = 0;
      items = <Item>[];
    }
  }
}
