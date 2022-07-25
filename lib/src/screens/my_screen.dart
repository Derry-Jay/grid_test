import '../helpers/helper.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  Widget getWidget(Stream<Barcode> e,
      {Widget Function(BuildContext, AsyncSnapshot<Barcode>)? builder}) {
    Widget itemBuilder(BuildContext context, AsyncSnapshot<Barcode> code) {
      try {
        return Flexible(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Image.memory(
                  fromIntList(code.hasData && !code.hasError
                      ? (code.data?.rawBytes ?? <int>[])
                      : <int>[]),
                  errorBuilder: errorBuilder),
              Text(code.hasData && !code.hasError
                  ? (code.data?.code ?? 'Error')
                  : 'Error')
            ]));
      } catch (e) {
        log(e);
        return const EmptyWidget();
      }
    }

    return StreamBuilder<Barcode>(builder: builder ?? itemBuilder, stream: e);
  }

  @override
  Widget build(BuildContext context) {
    final hp = Helper.of(context);
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
            height: hp.height,
            width: hp.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: css.map<Widget>(getWidget).toList())));
  }
}
