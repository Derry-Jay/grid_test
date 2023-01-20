import 'package:flutter/material.dart';
import 'package:grid_test/src/backend/api.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/models/city.dart';
import 'package:grid_test/src/models/county.dart';
import 'package:grid_test/src/models/route_argument.dart';

import '../widgets/empty_widget.dart';

class StateBasedCitiesScreen extends StatefulWidget {
  final RouteArgument rar;
  const StateBasedCitiesScreen({Key? key, required this.rar}) : super(key: key);

  @override
  StateBasedCitiesScreenState createState() => StateBasedCitiesScreenState();
}

class StateBasedCitiesScreenState extends State<StateBasedCitiesScreen> {
  Helper get hp => Helper.of(context);

  Widget listBuilder(BuildContext context, AsyncSnapshot<List<City>> cities) {
    Widget itemBuilder(BuildContext context, int index) {
      return Padding(
          padding: EdgeInsets.only(bottom: hp.height / 100),
          child: Row(
            children: [
              Text('${index + 1}.'),
              SizedBox(width: 32),
              Text(cities.data?[index].city ?? '')
            ],
          ));
    }

    try {
      switch (cities.connectionState) {
        case ConnectionState.done:
          return ListView.builder(
              padding:
                  EdgeInsets.only(left: hp.width / 40, top: hp.height / 80),
              itemBuilder: itemBuilder,
              itemCount: cities.data?.length);
        case ConnectionState.none:
          return const EmptyWidget();
        default:
          return const Center(child: CircularProgressIndicator());
      }
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cty = widget.rar.param as County;
    return Scaffold(
        appBar: AppBar(title: SelectableText(cty.county)),
        body: FutureBuilder<List<City>>(
            builder: listBuilder, future: getCities(cty.countyID)));
  }
}
