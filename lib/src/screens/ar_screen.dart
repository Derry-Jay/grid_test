import 'dart:io';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({Key? key}) : super(key: key);

  @override
  ARScreenState createState() => ARScreenState();
}

class ARScreenState extends State<ARScreen> {
  List<Map<String, dynamic>> listsData = <Map<String, dynamic>>[
    {
      'name': 'McDonald\'s',
      'latitude': 13.0067779,
      'longitude': 80.2535985,
      'url':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg'
    },
    {
      'name': 'Sangeetha Veg Restaurant',
      'latitude': 13.0102038,
      'longitude': 80.2462095,
      'url':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg'
    },
    {
      'name': 'Japanese School',
      'latitude': 12.9492127,
      'longitude': 80.2546826,
      'url':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg'
    }
  ];
  Helper get hp => Helper.of(context);

  void onARKitViewCreated(ARKitController arkitController) async {
    try {
      final perm = await Geolocator.checkPermission();
      final getPerm = perm == LocationPermission.always ||
              perm == LocationPermission.whileInUse
          ? perm
          : (await Geolocator.requestPermission());
      if (getPerm == LocationPermission.always ||
          getPerm == LocationPermission.whileInUse) {
        final currentposition = await Geolocator.getCurrentPosition();
        final point =
            LatLng(currentposition.latitude, currentposition.longitude);
        log(currentposition);
        for (Map<String, dynamic> data in listsData) {
          final locCor = LatLng(
              double.tryParse(data['latitude']?.toString() ?? '0.0') ?? 0.0,
              double.tryParse(data['longitude']?.toString() ?? '0.0') ?? 0.0);
          final distance = Geolocator.distanceBetween(point.latitude,
                  point.longitude, locCor.latitude, locCor.longitude) /
              10000;
          log(distance);
          if (distance < 10) {
            final capturedImage = await con.captureFromWidget(planeCreation(
                data['name'], distance.toStringAsFixed(2), data['url']));
            final directory = await getApplicationDocumentsDirectory();
            final pathOfImage = await File(
                    '${directory.path}/capturedImage${listsData.indexOf(data)}.png')
                .create();
            final bytes = capturedImage.buffer.asUint8List();
            final file = await pathOfImage.writeAsBytes(bytes);
            log(file.path);
            log(file == pathOfImage);
            final materialCard = ARKitMaterial(
                lightingModelName: ARKitLightingModel.lambert,
                diffuse: ARKitMaterialProperty.image(file.path));
            final image =
                ARKitPlane(height: 0.1, width: 0.4, materials: [materialCard]);
            log(getVector(locCor));
            // final v = getCoords(locCor);
            // v.add(-1.5);
            // log(v);
            await arkitController.add(ARKitNode(
                geometry: image,
                eulerAngles: Vector3.zero(),
                position: Vector3.array(getVector(locCor))));
          }
        }
      } else {
        final node = ARKitNode(
            geometry: ARKitSphere(radius: 0.1), position: Vector3(0, 0, -0.5));
        await arkitController.add(node);
      }
    } catch (e) {
      log(e);
    }
  }

  Widget planeCreation(String name, String distance, String url) {
    return RepaintBoundary(
      // key: key,
      child: Container(
        width: 150,
        height: 70,
        color: hp.theme.scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            MediaQuery(
                data: hp.dimensions,
                child: Image.network(url,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: errorBuilder)),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: Text(
                    name,
                    softWrap: true,
                    style:
                        TextStyle(color: hp.theme.primaryColor, fontSize: 16),
                  )),
                  Flexible(
                    child: Text(
                      '$distance Kms',
                      style: TextStyle(color: hp.theme.hintColor, fontSize: 15),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('ARKit in Flutter')),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated));
}
