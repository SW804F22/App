import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/map/view/map_form.dart';
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
    on<OnMarkerSelect>(_onMarkerSelect);
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
    emit(state.copyWith(
      markers : event.googleMarkers,
      customMarkers: event.customMarkers,
    ));
  }

  void _onMarkerSelect (
    OnMarkerSelect event,
    Emitter<MapState> emit,
  ) async {
    emit(state.copyWith(
      selectedMarker : event.selectedGoogleMarker,
    ));

    print(state.selectedMarker.name);
  }
}
