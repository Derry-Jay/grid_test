import 'company.dart';
import 'where_abouts.dart';
import '../helpers/helper.dart';

class User {
  final int userID;
  final Company company;
  final WhereAbouts address;
  final String name, profileName, email, phone, webSite;

  User(this.userID, this.name, this.profileName, this.email, this.address,
      this.phone, this.webSite, this.company);

  static User emptyUser = User(
      -1, '', '', '', WhereAbouts.emptyAddress, '', '', Company.emptyCompany);

  factory User.fromMap(Map<String, dynamic> json) {
    try {
      return User(
          json['id'] ?? '',
          json['name'] ?? '',
          json['username'] ?? '',
          json['email'] ?? '',
          WhereAbouts.fromMap(json['address'] ?? <String, dynamic>{}),
          json['phone'] ?? '',
          json['website'] ?? '',
          Company.fromMap(json['company'] ?? <String, dynamic>{}));
    } catch (e) {
      log(e);
      return User.emptyUser;
    }
  }
}
