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
    List<dynamic> allMarkers = await _mapsRepository.returnMarkers(lat: pos.latitude, long: pos.longitude);
    List<MarkerModel> customMarkers = [];
    
    if(allMarkers.isNotEmpty) {
      for (var poi in allMarkers) {
        var categoriesString = "";
        for (var categories in poi['categories']) {
          categoriesString += categories + ", ";
        }

        customMarkers.add(MarkerModel(
            poi['title'] as String,
            poi['id'] as String,
            poi['description'] as String,
            poi['longitude'] as double,
            poi['latitude'] as double,
            categoriesString,
            poi['website'] as String,
            poi['address'] as String,
            poi['priceStep'] as int)
        );
      }
    }
    emit(state.copyWith(
      customMarkers: customMarkers,
    ));
  }

  void _onUpdateGoogleMarkers(
      UpdateGoogleMarkers event,
      Emitter<MapState> emit,
      ) async {
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
