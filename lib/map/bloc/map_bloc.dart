import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import '../models/marker.dart';


part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState()) {
    on<MapMarkersChanged>(_onMarkersChanged);
    on<MapMarkersInit>(_onMarkersInit);
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
    print("We have not yet emitted");
    emit(state.copyWith(
      markers: newMarkers,
    ));
    print("We have emitted");
  }
}
