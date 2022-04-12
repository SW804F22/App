import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:poirecapi/global_styles.dart' as style;

import '../bloc/map_bloc.dart';
import '../models/marker.dart';

class MapForm extends StatelessWidget {

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
        List<Widget> cards = [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
            margin: EdgeInsets.symmetric(vertical: 7),
            child: ListTile (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              title: RichText(
                text: TextSpan(text: "Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: style.fontBig, color: Colors.black),
                ),
                textAlign: TextAlign.center,
                ),
              subtitle: state.selectedMarker.description.isNotEmpty
                  ? Text(state.selectedMarker.description, style: TextStyle(fontSize: style.fontMedium),)
                  : Text("No description available", style: TextStyle(fontSize: style.fontMedium),),
              textColor: Colors.black,
              tileColor: style.fourth,
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
            margin: EdgeInsets.symmetric(vertical: 7),
            child: ListTile (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              title: RichText(
                text: TextSpan(text: "Info",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: style.fontBig, color: Colors.black),
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: RichText(text: TextSpan(text: state.selectedMarker.address.isNotEmpty
                  ? 'Category:\n${state.selectedMarker.categories} \n\n'
                  : "No category available\n",
                  style: TextStyle(fontSize: style.fontMedium, color: Colors.black),
                  children: [
                    TextSpan(
                      text:  state.selectedMarker.website.isNotEmpty
                          ? 'Price Step: ${state.selectedMarker.price}'
                          : "No price information available\n",
                      style: TextStyle(fontSize: style.fontMedium, color: Colors.black),
                    ),
                  ]),),
              textColor: Colors.black,
              tileColor: style.fourth,
            ),
          ),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
            margin: EdgeInsets.symmetric(vertical: 7),
            child: ListTile (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              title: RichText(
                text: TextSpan(text: "Where to find",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: style.fontBig, color: Colors.black),
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: RichText(text: TextSpan(text: state.selectedMarker.address.isNotEmpty
                  ? 'Address:\n${state.selectedMarker.address} \n\n'
                  : "No address available\n",
                  style: TextStyle(fontSize: style.fontMedium, color: Colors.black),
                  children: [
                TextSpan(
                  text:  state.selectedMarker.website.isNotEmpty
                      ? 'Website:\n${state.selectedMarker.website}'
                      : "No website available\n",
                    style: TextStyle(fontSize: style.fontMedium, color: Colors.black),
                ),
              ]),),
              textColor: Colors.black,
              tileColor: style.fourth,
            ),
          ),

        ];
        LatLngBounds pos;
        List poIList;
        final List<MarkerModel> markers = [];
        final Set<Marker> googleMarkers = {};
        String categoriesString;
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

              if(poIList.isNotEmpty){

                for(var poi in poIList){
                  categoriesString = "",
                  for(var categories in poi['categories']){
                    categoriesString += categories + ", "
                  },

                  markers.add(MarkerModel(
                      poi['title'] as String,
                      poi['id'] as String,
                      poi['description'] as String,
                      poi['longitude'] as double,
                      poi['latitude'] as double,
                      categoriesString,
                      poi['website'] as String,
                      poi['address'] as String,
                      poi['priceStep'] as int)),
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
                                        scrollable: true,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                                        backgroundColor: style.tertiary,
                                        title: Text(
                                            state.selectedMarker.name, textAlign: TextAlign.center,),
                                        content: Column(
                                          children: cards,
                                        ),
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
                      )
                  ),
                },
                context.read<MapBloc>().add(
                    MapStoppedEvent(googleMarkers, markers))
              },
              },
            ),
          ),
        );
      },
    );
  }
}