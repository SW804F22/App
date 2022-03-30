part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.markers = const <Marker>{},
    this.customMarkers = const <marker>[],
    this.position = const LatLng(0, 0),
    this.selectedMarker = const marker("", "", "", 0, 0, "", "", "", 0),
  });

  final Set<Marker> markers;
  final List<marker> customMarkers;
  final marker selectedMarker;
  final LatLng position;

  MapState copyWith({
    Set<Marker>? markers,
    List<marker>? customMarkers,
    LatLng? position,
    marker? selectedMarker,
  }) {
    return MapState(
    markers: markers ?? this.markers,
    customMarkers: customMarkers ?? this.customMarkers,
    position: position ?? this.position,
    selectedMarker: selectedMarker ?? this.selectedMarker,
    );
  }

  @override
  List<Object> get props => [markers, customMarkers, position, selectedMarker];
}