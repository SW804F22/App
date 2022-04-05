part of 'poi_bloc.dart';

class PoiState extends Equatable {
  const PoiState({
    this.allPois = const <Map<String, dynamic>>[],
    this.position = const LatLng(0,0),
    this.searchQuery = "",
});

  final List<Map<String, dynamic>> allPois;
  final LatLng position;
  final String searchQuery;

  // Copy final value to modify it
  PoiState copyWith({
    List<Map<String, dynamic>>? allPois,
    LatLng? position,
    String? searchQuery
  }) {
    return PoiState(
      allPois: allPois ?? this.allPois,
      position: position ?? this.position,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [allPois, position, searchQuery];
}


