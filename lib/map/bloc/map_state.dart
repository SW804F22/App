part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.markers = const <Marker>{},
    this.customMarkers = const <MarkerModel>[],
    this.position = const LatLng(0, 0),
    this.selectedMarker = const MarkerModel("", "", "", 0, 0, "", "", "", 0),
    this.rebuildPoi = true,
  });

  final Set<Marker> markers;
  final List<MarkerModel> customMarkers;
  final MarkerModel selectedMarker;
  final LatLng position;
  final bool rebuildPoi;

  MapState copyWith({
    Set<Marker>? markers,
    List<MarkerModel>? customMarkers,
    LatLng? position,
    MarkerModel? selectedMarker,
    bool? rebuildPoi,
  }) {
    return MapState(
      markers: markers ?? this.markers,
      customMarkers: customMarkers ?? this.customMarkers,
      position: position ?? this.position,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      rebuildPoi: rebuildPoi ?? this.rebuildPoi,
    );
  }

  @override
  List<Object> get props => [markers, customMarkers, position, selectedMarker, rebuildPoi];
}
