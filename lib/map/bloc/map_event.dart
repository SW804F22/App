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