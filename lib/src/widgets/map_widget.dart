import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grid_test/src/helpers/helper.dart';
import 'package:grid_test/src/widgets/empty_widget.dart';
import 'package:location/location.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({Key? key}) : super(key: key);

  void placedCoordinates(GoogleMapController mapController) async {
    final currentposition = await Geolocator.getCurrentPosition();
    final point = LatLng(currentposition.latitude, currentposition.longitude);
    await mapController.animateCamera(CameraUpdate.newLatLng(point));
    log(currentposition);
    log('currentPosition');
    log(point);
  }

  void onMapCreated(GoogleMapController googleMapController) {
    try {
      mapCon = googleMapController;
      completer.complete(googleMapController);
      placedCoordinates(googleMapController);
    } catch (e) {
      log(e);
    }
  }

  void cameraMovement(CameraPosition position) async {
    await mapCon?.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  Widget mapBuilder(BuildContext context, AsyncSnapshot<LocationData> region) {
    log(region.data);
    try {
      return 
      // region.hasData && !region.hasError? 
          GoogleMap(
              trafficEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              initialCameraPosition: CameraPosition(
                  target: LatLng(region.data?.latitude ?? 0.0,
                      region.data?.longitude ?? 0.0)))
          // : const EmptyWidget()
          ;
    } catch (e) {
      log(e);
      return const EmptyWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LocationData>(
        builder: mapBuilder, stream: place.onLocationChanged);
  }
}
