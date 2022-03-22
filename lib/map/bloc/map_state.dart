part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.markers = const <Marker>{},

  });

  final Set<Marker> markers;

  MapState copyWith({
    Set<Marker>? markers,
  }) {
    return MapState(
    markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [markers];
}