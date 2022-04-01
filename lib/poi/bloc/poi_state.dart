part of 'poi_bloc.dart';

class PoiState extends Equatable {
  const PoiState({
    this.allPois = const <Map<String, dynamic>>[],
    this.position = const LatLng(0,0)
});

  final List<Map<String, dynamic>> allPois;
  final LatLng position;

  // Copy final value to modify it
  PoiState copyWith({
    List<Map<String, dynamic>>? allPois,
    LatLng? position,
  }) {
    return PoiState(
      allPois: allPois ?? this.allPois,
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [allPois, position];
}


