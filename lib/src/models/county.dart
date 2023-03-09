import '../helpers/helper.dart';

class County {
  final int countyID;
  final String county;

  static County emptyCounty = County(-1, '');

  County(this.countyID, this.county);

  factory County.fromMap(Map<String, dynamic> map) {
    try {
      return County(int.tryParse(map['id'] ?? '') ?? -1, map['name'] ?? '');
    } catch (e) {
      log(e);
      return County.emptyCounty;
    }
  }
}
