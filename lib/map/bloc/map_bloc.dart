import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    print("OnMarkersChanged");
  }

  void _onMarkersInit(
      MapMarkersInit event,
      Emitter<MapState> emit,)
  {
    print("I am here, and I am queer");
  }
}
