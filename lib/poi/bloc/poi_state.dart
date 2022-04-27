part of 'poi_bloc.dart';

class PoiState extends Equatable {
  const PoiState({
    this.allPois = const <Map<String, dynamic>>[],
    this.position = const LatLng(0,0),
    this.categories = const <String>[]
});

  final List<Map<String, dynamic>> allPois;
  final LatLng position;
  final List<String> categories;

  // Copy final value to modify it
  PoiState copyWith({
    List<Map<String, dynamic>>? allPois,
    LatLng? position,
    List<String>? categories
  }) {
    return PoiState(
      allPois: allPois ?? this.allPois,
      position: position ?? this.position,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object> get props => [allPois, position, categories];
}


