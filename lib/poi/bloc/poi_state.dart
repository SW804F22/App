part of 'poi_bloc.dart';

class PoiState extends Equatable {
  const PoiState({
    this.allPois = const <Map<String, dynamic>>[]
});

  final List<Map<String, dynamic>> allPois;

  // Copy final value to modify it
  PoiState copyWith({
    List<Map<String, dynamic>>? allPois,
  }) {
    return PoiState(
      allPois: allPois ?? this.allPois,
    );
  }

  @override
  List<Object> get props => [];
}


