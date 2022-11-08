import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import '../models/base.dart';
import '../models/product.dart';
import 'package:http/http.dart';
import '../helpers/helper.dart';
import '../models/some_item.dart';
import 'package:global_configuration/global_configuration.dart';

GlobalConfiguration? gc;
final httpClient = HttpClient();
StreamController<List<Product>> productsController =
    StreamController<List<Product>>.broadcast(onListen: () {
  log('listening');
}, onCancel: () {
  log('cancel');
});

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
  } else {
    yield number;
  }
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

void getProducts(int seconds) async {
  try {
    await Future.delayed(Duration(seconds: seconds), () async {
      final cl = Client();
      final res = await cl.get(
          Uri.tryParse('https://api.escuelajs.co/api/v1/products') ?? Uri());
      cl.close();
      final list = List<Map<String, dynamic>>.from(json.decode(res.body))
          .map<Product>(Product.fromMap)
          .toList();
      log(list.length);
      list.isEmpty
          ? doNothing()
          : productsController.add(list);
      // : productsController.sink.add(list);
    });
  } catch (e) {
    log(e);
  }
}

Future<Base> getData() async {
  try {
    final request = await httpClient.getUrl(
        Uri.tryParse('https://jsonplaceholder.typicode.com/users') ?? Uri());
    final response = await request.close();
    final resStr = await response.transform(utf8.decoder).join();
    log(resStr);
    return response.statusCode == 200
        ? Base.fromMap(json.decode(resStr))
        : Base.emptyBase;
  } catch (e) {
    log(e);
    return Base.emptyBase;
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

Future<String> sendData(Map<String, dynamic> map) async {
  try {
    return (await Client()
            .post(Uri.tryParse('https://crudcrud.com/api/') ?? Uri()))
        .body;
  } catch (e) {
    log(e);
    return '';
  }
}
