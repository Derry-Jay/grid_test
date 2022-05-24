import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:global_configuration/global_configuration.dart';

final client = Client();
final gc = GlobalConfiguration();
final httpClient = HttpClient();
final stu = gc.getValue<String>('staging');
final tsu = gc.getValue<String>('testing');

Stream<int> getValues(int seconds) async* {
  final rand = Random(0);
  while (true) {
    await Future.delayed(Duration(seconds: seconds));
    yield rand.nextInt(10);
  }
}
