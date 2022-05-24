import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:global_configuration/global_configuration.dart';

final client = Client();
GlobalConfiguration? gc;
final httpClient = HttpClient();
// final stu = gc.getValue<String>('staging');
// final tsu = gc.getValue<String>('testing');

Stream<int> getValues(int seconds) async* {
  final rand = Random(0);
  while (true) {
    await Future.delayed(Duration(seconds: seconds));
    yield rand.nextInt(10);
  }
}

Stream<List<SomeItem>> getData() async* {
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.get(url);
    yield response.statusCode == 200
        ? List<Map<String, dynamic>>.from(json.decode(response.body))
            .map<SomeItem>(SomeItem.fromMap)
            .toList()
        : <SomeItem>[];
  } catch (e) {
    log(e);
    yield <SomeItem>[];
  }
}

Future obtainData(Map<String, dynamic> body) async {
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.post(url, body: body);
    log(response.statusCode);
    log(response.body);
    final data = json.decode(response.body) as Map<String, dynamic>;
    // Map<String, dynamic> userMap = json.decode(response.body);
    // // var deliverystock = ShowNotification.fromMap(userMap);
    // // return deliverystock;
    // return response.statusCode == 200
    //     ? Reply.fromMap(userMap)
    //     : Reply.emptyReply;
    return data;
  } catch (e) {
    log(e);
    rethrow;
  }
}
