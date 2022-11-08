import '../helpers/helper.dart';

class Company {
  final String name, catchPhrase, bs;

  Company(this.name, this.catchPhrase, this.bs);

  static Company emptyCompany = Company('', '', '');

  factory Company.fromMap(Map<String, dynamic> json) {
    try {
      return Company(
          json['name'] ?? '', json['catchPhrase'] ?? '', json['bs'] ?? '');
    } catch (e) {
      log(e);
      return Company.emptyCompany;
    }
  }

  @override
  bool operator ==(Object other) {
    return other is Company &&
        name == other.name &&
        catchPhrase == other.catchPhrase &&
        bs == other.bs;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => name.hashCode + catchPhrase.hashCode + bs.hashCode;
}
