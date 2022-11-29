import 'package:grid_test/src/helpers/helper.dart';

class City {
  final int cityID;
  final String city;

  static City emptyCity = City(-1, '');

  City(this.cityID, this.city);
  factory City.fromMap(Map<String, dynamic> map) {
    try {
      return City(int.tryParse(map['city_id'] ?? '') ?? -1, map['city'] ?? '');
    } catch (e) {
      log(e);
      return City.emptyCity;
    }
  }
}
