import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as PH;
import '../../authentication/bloc/authentication_bloc.dart';
import 'package:location/location.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:authentication_repository/authentication_repository.dart';


import '../bloc/map_bloc.dart';
import '../models/marker.dart';

class MapForm extends StatelessWidget {

  //final bloc = MapBloc();
  late GoogleMapController mapController;
  final AuthenticationRepository _authenticationRepository = new AuthenticationRepository();
  Location _location = Location();
  final LatLng _center = const LatLng(55.6, 12.5);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;


    var loc = await _location.getLocation();
    controller.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(loc.latitude!, loc.longitude!),
                zoom: 15.0
            )
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      buildWhen: (previous, current) => previous.markers != current.markers || previous.selectedMarker != current.selectedMarker,
      builder: (context, state) {
        LatLngBounds pos;
        List PoIList;
        List<marker> markers = [];
        Set<Marker> googleMarkers = {};
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: _center, zoom: 14.0),
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: state.markers,
              onCameraIdle: () async =>
              {
                pos = await mapController.getVisibleRegion(),
                PoIList = await _authenticationRepository.returnMarkers(
                    (pos.northeast.latitude + pos.southwest.latitude) / 2,
                    (pos.northeast.longitude + pos.southwest.longitude) / 2),

                for(var poi in PoIList){
                  markers.add(new marker(
                      poi['title'],
                      poi['uuid'],
                      poi['description'],
                      poi['longitude'],
                      poi['latitude'],
                      "Some category",
                      poi['website'],
                      poi['address'],
                      poi['priceStep']))
                },

                for(var marker in markers){
                  googleMarkers.add(
                      new Marker(
                        markerId: MarkerId(marker.UUID),
                        position: LatLng(marker.lat, marker.long),
                        onTap: () =>
                        {
                          context.read<MapBloc>().add(OnMarkerSelect(marker)),
                        },
                        infoWindow: InfoWindow(
                          onTap: () =>
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: Text(
                                            state.selectedMarker.name),
                                        content: Text(
                                            state.selectedMarker.website),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(
                                                      context, "Cancel"),
                                              child: Text("Cancel"))
                                        ],
                                      )
                              ),
                          title: marker.name,
                          snippet: marker.description,
                        ),
                      )),
                },
                context.read<MapBloc>().add(
                    MapStoppedEvent(googleMarkers, markers))
              },
            ),),
        );
      },
    );
  }
}