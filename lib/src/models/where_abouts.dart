import '../helpers/helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WhereAbouts {
  final LatLng point;
  final String lane, suite, city, zipCode;

  WhereAbouts(this.lane, this.suite, this.city, this.zipCode, this.point);

  static WhereAbouts emptyAddress =
      WhereAbouts('', '', '', '', const LatLng(0.0, 0.0));

  factory WhereAbouts.fromMap(Map<String, dynamic> json) {
    try {
      final geo = json['geo'] as Map<String, dynamic>?;
      return WhereAbouts(
          json['street'] ?? '',
          json['suite'] ?? '',
          json['city'] ?? '',
          json['zipcode'] ?? '',
          LatLng(double.tryParse(geo?['lat'] ?? '') ?? 0.0,
              double.tryParse(geo?['lng'] ?? '') ?? 0.0));
    } catch (e) {
      log(e);
      return WhereAbouts.emptyAddress;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is WhereAbouts &&
        lane == other.lane &&
        suite == other.suite &&
        city == other.city &&
        zipCode == other.zipCode;
  }

  @override
  // TODO: implement hashCode
  int get hashCode =>
      lane.hashCode + suite.hashCode + city.hashCode + zipCode.hashCode;
}
