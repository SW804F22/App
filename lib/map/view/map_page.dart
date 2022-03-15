import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as PH;
import '../../authentication/bloc/authentication_bloc.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MapPage());
  }

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;
  Location _location = Location();
  final LatLng _center = const LatLng(30.52, -100.67);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    var loc =  await _location.getLocation();
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(loc.latitude!, loc.longitude!),
                zoom: 13.0
            )
        ));

      _location.onLocationChanged.listen((l) {
        controller.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(l.latitude!, l.longitude!),
                    zoom: 13.0
                )
            ));
      });
  }

  Future<PH.PermissionStatus> LocationPermission() async {
    return await PH.Permission.location.status;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
