import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_repository/maps_repository.dart';
import 'package:meta/meta.dart';
import 'package:poi_repository/poi_repository.dart';
import '../models/marker.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required MapsRepository mapsRepository,
    required PoiRepository poiRepository,
  }) : _mapsRepository = mapsRepository,
       _poiRepository = poiRepository,
       super(MapState()) {
    on<MapStoppedEvent>(_onMapStoppedEvent);
    on<OnMarkerSelect>(_onMarkerSelect);
    on<UpdateGoogleMarkers>(_onUpdateGoogleMarkers);
  }

  final MapsRepository _mapsRepository;
  final PoiRepository _poiRepository;

  void _onMapStoppedEvent(
      MapStoppedEvent event,
      Emitter<MapState> emit,
      ) async
  {
    var pos = event.position;
    _poiRepository.position = pos;
    emit(state.copyWith(
      markers: event.googleMarkers,
      customMarkers: event.customMarkers,
    ));
  }

  void _onUpdateGoogleMarkers(
      UpdateGoogleMarkers event,
      Emitter<MapState> emit,
      ) async {
    print(event.googleMarkers.length);
    print(event.googleMarkers);
    emit(state.copyWith(
      markers: event.googleMarkers,
    ));
  }

  void _onMarkerSelect (
    OnMarkerSelect event,
    Emitter<MapState> emit,
  ) async {

    emit(state.copyWith(
      selectedMarker : event.selectedGoogleMarker,
    ));
  }
}
