import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:flutter/foundation.dart';
import 'package:global_configuration/global_configuration.dart';

GlobalConfiguration? gc;
final httpClient = HttpClient();
ValueNotifier<List<int>?> bytes = ValueNotifier(null);

Iterable<int> getNumbers(int number) sync* {
  log('generator started');
  for (int i = 1; i <= number; i++) {
    yield i;
  }
  log('generator ended');
}

Iterable<int> getNumbersRecursive(int number) sync* {
  log('generator $number started');
  if (number > 0) {
    yield* getNumbersRecursive(number - 1);
  }
  yield number;
  log('generator $number ended');
}

Stream<int> getValues(int seconds) async* {
  final rand = Random(0);
  while (true) {
    await Future.delayed(Duration(seconds: seconds));
    yield rand.nextInt(10);
  }
}

Stream<List<SomeItem>> receiveData(Duration duration) async* {
  final client = Client();
  try {
    while (true) {
      await Future.delayed(duration);
      final url =
          Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
      final response = await client.get(url);
      // client.close();
      yield response.statusCode == 200
          ? List<Map<String, dynamic>>.from(json.decode(response.body))
              .map<SomeItem>(SomeItem.fromMap)
              .toList()
          : <SomeItem>[];
    }
  } catch (e) {
    log(e);
    client.close();
    yield <SomeItem>[];
  }
}

Future<List<SomeItem>> obtainData() async {
  final client = Client();
  try {
    final url =
        Uri.tryParse('https://jsonplaceholder.typicode.com/todos') ?? Uri();
    final response = await client.get(url);
    // client.close();
    log(response.statusCode);
    log(response.body);
    // Map<String, dynamic> userMap = json.decode(response.body);
    // // var deliverystock = ShowNotification.fromMap(userMap);
    // // return deliverystock;
    // return response.statusCode == 200
    //     ? Reply.fromMap(userMap)
    //     : Reply.emptyReply;
    return response.statusCode == 200
        ? List<Map<String, dynamic>>.from(json.decode(response.body))
            .map<SomeItem>(SomeItem.fromMap)
            .toList()
        : <SomeItem>[];
  } catch (e) {
    log(e);
    client.close();
    rethrow;
  }
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';
  try {
    myUrl = '$url/$fileName';
    final request = await httpClient.getUrl(Uri.parse(myUrl));
    final response = await request.close();
    if (response.statusCode == 200) {
      final bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      final byteFile = await file.writeAsBytes(bytes);
      log(byteFile.path);
    } else {
      filePath = 'Error code: ${response.statusCode}';
    }
  } catch (e) {
    log(e);
    filePath = 'Can not fetch url';
  }

  return filePath;
}

Future<Map<String, dynamic>> getMap() async {
  try {
    final request = await httpClient
        .getUrl(Uri.tryParse('http://127.0.0.1:8000/') ?? Uri());
    final response = await request.close();
    final resStr = await response.transform(utf8.decoder).join();
    log(resStr);
    return response.statusCode == 200
        ? json.decode(resStr) as Map<String, dynamic>
        : <String, dynamic>{};
  } catch (e) {
    log(e);
    return <String, dynamic>{};
  }
}

Future<Map<String, dynamic>> obtainMap() async {
  try {
    final request = await httpClient
        .postUrl(Uri.tryParse('http://127.0.0.1:8000/values') ?? Uri());
    request.write(jsonEncode({'limit': 50}));
    final response = await request.close();
    final resStr = await response.transform(utf8.decoder).join();
    log(resStr);
    return response.statusCode == 200
        ? json.decode(resStr) as Map<String, dynamic>
        : <String, dynamic>{};
  } catch (e) {
    log(e);
    return <String, dynamic>{};
  }
}
