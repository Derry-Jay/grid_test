import '../helpers/helper.dart';

class Item {
  late int id;
  late String name, type, code, cate, owner, amount, date;
  late bool status;
  Item();
  Item.fromMap(Map<String, dynamic> body) {
    try {
      final list = List<String>.from(body['data']);
      id = int.tryParse(body['id']) ?? -1;
      name = list[2];
      type = list[1];
      code = list[3];
      cate = list[7];
      owner = list[8];
      amount = (((double.tryParse(list[10]) ?? 0.0) +
                  (double.tryParse(list[11]) ?? 0.0) +
                  (double.tryParse(list[13]) ?? 0.0)) /
              3)
          .toString();
      date = list[9];
    } catch (e) {
      id = -1;
      name = '';
      type = '';
      code = '';
      cate = '';
      owner = '';
      amount = '';
      date = '';
      log(e);
      rethrow;
    }
  }
}
