import 'user.dart';
import 'company.dart';
import 'where_abouts.dart';
import '../helpers/helper.dart';

class Base {
  final List<User> users;
  final List<Company> companies;
  final List<WhereAbouts> addresses;

  Base(this.users, this.companies, this.addresses);

  static Base emptyBase = Base(<User>[], <Company>[], <WhereAbouts>[]);

  factory Base.fromMap(List ls) {
    try {
      final list = List<Map<String, dynamic>>.from(ls);
      if (list.isNotEmpty) {
        List<Company> cl = <Company>[];
        List<WhereAbouts> al = <WhereAbouts>[];
        final ul = list.map<User>(User.fromMap).toList();
        for (User element in ul) {
          cl.contains(element.company) ? doNothing() : cl.add(element.company);
          al.add(element.address);
        }
        return Base(ul, cl, al);
      } else {
        return Base.emptyBase;
      }
    } catch (e) {
      log(e);
      return Base.emptyBase;
    }
  }
}
