import 'dart:typed_data';
import '../helpers/helper.dart';
import '../widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({Key? key}) : super(key: key);

  @override
  QRScanScreenState createState() => QRScanScreenState();
}

class QRScanScreenState extends State<QRScanScreen> {
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ValueNotifier<List<int>?> image = ValueNotifier(null);
  ValueNotifier<String?> code = ValueNotifier(null);
  Helper get hp => Helper.of(context);

  void onQRViewCreated(QRViewController con) {
    void onData(Barcode event) async {
      await con.pauseCamera();
      if (event.rawBytes != null) {
        image.value = event.rawBytes;
        hp.onChange();
      }
      log(event.code);
      if (event.code != null) {
        code.value = event.code;
        hp.onChange();
      }
      await con.resumeCamera();
    }

    void onDone() async {
      await con.stopCamera();
    }

    void onError(Object val, StackTrace trace) async {
      await con.pauseCamera();
      log(val);
      log(trace);
      await con.resumeCamera();
    }

    if (!css.contains(con.scannedDataStream)) {
      css.add(con.scannedDataStream);
    }
    final cs =
        con.scannedDataStream.listen(onData, onError: onError, onDone: onDone);
    if (!scs.contains(cs)) {
      scs.add(cs);
    }
  }

  Widget imageBuilder(BuildContext context, List<int>? pic, Widget? child) {
    try {
      return (pic?.isEmpty ?? true)
          ? (child ?? const EmptyWidget())
          : Image.memory(Uint8List.fromList(pic!), errorBuilder: errorBuilder);
    } catch (e) {
      log(e);
      return child ?? const EmptyWidget();
    }
  }

  Widget codeBuilder(BuildContext context, String? code, Widget? child) {
    return Text(code ?? '');
  }

  Widget codeStreamBuilder(
      BuildContext context, AsyncSnapshot<Barcode> result) {
    return Column(
      children: [
        Text(result.hasData && !result.hasError
            ? (result.data?.code ?? '')
            : ''),
        Image.memory(Uint8List.fromList(result.data?.rawBytes ?? <int>[]),
            errorBuilder: errorBuilder)
      ],
    );
  }

  void customDispose() async {
    if (css.isNotEmpty && css.remove(css.last)) {
      log('dispose');
    }
    log(css);
    if (scs.isEmpty) {
      log('Empty');
    } else {
      final q = await scs.last.asFuture();
      await scs.last.cancel();
      log(q);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    customDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                height: hp.height,
                width: hp.width,
                child: Column(children: [
                  const Text('Welcome'),
                  Expanded(
                      child: Row(
                    children: [
                      ValueListenableBuilder<List<int>?>(
                          valueListenable: image, builder: imageBuilder),
                      ValueListenableBuilder<String?>(
                          valueListenable: code, builder: codeBuilder),
                      Flexible(
                          child: QRView(
                              key: qrKey,
                              onQRViewCreated: onQRViewCreated,
                              overlay: QrScannerOverlayShape(
                                  cutOutWidth: hp.width,
                                  cutOutHeight: hp.height / 2)))
                    ],
                  )),
                  const Expanded(child: Text('Hi')),
                  // const Expanded(child: )
                  // ,const ,
                  // const Expanded(child: ),
                  // Expanded(child: )
                ]))));
  }
}
