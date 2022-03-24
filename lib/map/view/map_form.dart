import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as PH;
import '../../authentication/bloc/authentication_bloc.dart';
import 'package:location/location.dart';
import 'package:get_it/get_it.dart';

import '../bloc/map_bloc.dart';

class MapForm extends StatelessWidget {

  //final bloc = MapBloc();
  late GoogleMapController mapController;
  Location _location = Location();
  final LatLng _center = const LatLng(55.6, 12.5);


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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (previous, current) => previous.markers != current.markers,
      builder: (context, state) {
        LatLngBounds pos;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: _center, zoom: 11.0),
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: state.markers,
              onCameraIdle: () async => {
                pos = await mapController.getVisibleRegion(),
                context.read<MapBloc>().add(MapStoppedEvent(new LatLng(
                    (pos.northeast.latitude + pos.southwest.latitude)/2,
                    (pos.northeast.longitude + pos.southwest.longitude)/2)))
              },
            ),
          ),
        );
      },
    );
  }
}