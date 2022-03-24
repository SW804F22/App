import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import '../models/marker.dart';
import 'package:http/http.dart' as http;


part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<MapMarkersChanged>(_onMarkersChanged);
    on<MapMarkersInit>(_onMarkersInit);
    on<MapStoppedEvent>(_onCameraPosChange);
  }

  void _onMarkersChanged(
      MapMarkersChanged event,
      Emitter<MapState> emit,)
  {

  }

  void _onMarkersInit(
      MapMarkersInit event,
      Emitter<MapState> emit,) async
  {

    final Set<Marker> newMarkers = {new Marker(markerId: new MarkerId('value'), position: LatLng(57.04, 9.93))};
    emit(state.copyWith(
      markers: newMarkers,
    ));
  }

  void _onCameraPosChange(
      MapStoppedEvent event,
      Emitter<MapState> emit,
      ) async
  {

    var pos = event.position;

    print("Sending request!");

    final response = await http.get(
      Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?' + "latitude="
          + pos.latitude.toString() + "&" + "longitude=" + pos.longitude.toString() + "&" + "distance=" + "0.05"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );

    List poiList = json.decode(response.body);

    List<marker> markers = [];
    Set<Marker> googleMarkers = {};

    for(var poi in poiList){
      markers.add(new marker(poi['title'], poi['uuid'], poi['description'],
                             poi['longitude'], poi['latitude'], "Some category",
                             poi['website'], poi['address'], poi['priceStep']));

    }

    for(var marker in markers){
      googleMarkers.add(
          new Marker(
            markerId: new MarkerId(marker.UUID),
            position: new LatLng(marker.lat, marker.long),
            infoWindow: new InfoWindow(title: marker.name, snippet: marker.description),
      ));
    }
    // Set<Marker> newMarkers = {new Marker(markerId: new MarkerId('value'), position: LatLng(57.04, 9.93))};
    emit(state.copyWith(
      markers : googleMarkers,
      customMarkers: markers,
    ));
  }
}
