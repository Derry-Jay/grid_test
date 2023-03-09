import 'package:flutter/material.dart';
import 'package:grid_test/src/backend/api.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/models/county.dart';
import 'package:grid_test/src/models/route_argument.dart';
import 'package:grid_test/src/widgets/empty_widget.dart';

class StatesScreen extends StatefulWidget {
  const StatesScreen({super.key});

  @override
  State<StatesScreen> createState() => _StatesScreenState();
}

class _StatesScreenState extends State<StatesScreen> {
  Helper get hp => Helper.of(context);

  Widget listBuilder(
      BuildContext context, AsyncSnapshot<List<County>> counties) {
    Widget itemBuilder(BuildContext context, int index) {
      return GestureDetector(
          onTap: () {
            hp.goTo('/cities',
                args: RouteArgument(
                    param: counties.data?[index] ?? County.emptyCounty));
          },
          child: Padding(
              padding: EdgeInsets.only(bottom: hp.height / 100),
              child: Row(
                children: [
                  Text('${index + 1}.'),
                  SizedBox(width: 32),
                  Text(counties.data?[index].county ?? '')
                ],
              )));
    }

    try {
      switch (counties.connectionState) {
        case ConnectionState.done:
          return ListView.builder(
              padding:
                  EdgeInsets.only(left: hp.width / 40, top: hp.height / 80),
              itemBuilder: itemBuilder,
              itemCount: counties.data?.length);
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
    return Scaffold(
        bottomNavigationBar: Text(
          'Click on each state to view it\'s cities',
          textAlign: TextAlign.center,
        ),
        appBar: AppBar(title: SelectableText('States')),
        body: FutureBuilder<List<County>>(
            builder: listBuilder, future: obtainStates()));
  }
}
