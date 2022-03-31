import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:authentication_repository/authentication_repository.dart';


import '../bloc/map_bloc.dart';
import '../models/marker.dart';

class MapForm extends StatelessWidget {

  //final bloc = MapBloc();
  late GoogleMapController mapController;
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  final Location _location = Location();
  final LatLng _center = const LatLng(55.6, 12.5);

  MapForm({Key? key}) : super(key: key);

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;


    final loc = await _location.getLocation();
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
        List poIList;
        final List<MarkerModel> markers = [];
        final Set<Marker> googleMarkers = {};
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: _center, zoom: 14.0),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: state.markers,
              onCameraIdle: () async =>
              {
                pos = await mapController.getVisibleRegion(),
                poIList = await _authenticationRepository.returnMarkers(
                    (pos.northeast.latitude + pos.southwest.latitude) / 2,
                    (pos.northeast.longitude + pos.southwest.longitude) / 2),

                for(var poi in poIList){
                  markers.add(MarkerModel(
                      poi['title'] as String,
                      poi['uuid'] as String,
                      poi['description'] as String,
                      poi['longitude'] as double,
                      poi['latitude'] as double,
                      "Some category",
                      poi['website'] as String,
                      poi['address'] as String,
                      poi['priceStep'] as int))
                },

                for(var marker in markers){
                  googleMarkers.add(
                      Marker(
                        markerId: MarkerId(marker.uuid),
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
