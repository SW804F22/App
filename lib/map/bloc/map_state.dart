part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState({
    this.markers = List<marker>,

  });

  final markers;

  MapState copyWith({
    marker? markers,
  }) {
    return MapState(
    markers: markers ?? this.markers,
    );
  }

  @override
  List<Object> get props => [markers];
}