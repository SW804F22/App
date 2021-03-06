part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class MapMarkersChanged extends MapEvent {
  const MapMarkersChanged(this.markers);

  final List<Marker> markers;

  @override
  List<Object> get props => [markers];
}

class MapMarkersInit extends MapEvent {
  const MapMarkersInit();


  @override
  List<Object> get props => [];
}

class MapStoppedEvent extends MapEvent {
  const MapStoppedEvent(this.position, this.googleMarkers, this.customMarkers);

  //final Set<Marker> googleMarkers;
  final LatLng position;
  final Set<Marker> googleMarkers;
  final List<MarkerModel> customMarkers;

  @override
  List<Object> get props => [position, googleMarkers, customMarkers];
}

class UpdateGoogleMarkers extends MapEvent {
  const UpdateGoogleMarkers(this.googleMarkers);

  final Set<Marker> googleMarkers;

  @override
  List<Object> get props => [googleMarkers];
}

class OnMarkerSelect extends MapEvent {
  const OnMarkerSelect(this.selectedGoogleMarker);

  final MarkerModel selectedGoogleMarker;

  @override
  List<Object> get props => [selectedGoogleMarker];
}

class OnMarkerAddTap extends MapEvent {
  const OnMarkerAddTap(this.newMarkerSet);

  final Set<Marker> newMarkerSet;

  @override
  List<Object> get props => [newMarkerSet];
}
