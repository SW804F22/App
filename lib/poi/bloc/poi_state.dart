part of 'poi_bloc.dart';

class PoiState extends Equatable {
  const PoiState({
    this.allPois = const <Map<String, dynamic>>[],
    this.position = const LatLng(0,0),
    this.allCategories = const <String>[],
    this.selectedCategories = const <String>[]
});

  final List<Map<String, dynamic>> allPois;
  final LatLng position;
  final List<String> allCategories;
  final List<String> selectedCategories;

  // Copy final value to modify it
  PoiState copyWith({
    List<Map<String, dynamic>>? allPois,
    LatLng? position,
    List<String>? allCategories,
    List<String>? selectedCategories,
  }) {
    return PoiState(
      allPois: allPois ?? this.allPois,
      position: position ?? this.position,
      allCategories: allCategories ?? this.allCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories
    );
  }

  @override
  List<Object> get props => [allPois, position, allCategories, selectedCategories];
}


