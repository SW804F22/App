part of 'poi_bloc.dart';

abstract class PoiEvent extends Equatable {
  const PoiEvent();

  @override
  List<Object> get props => [];
}

//When the screen is first loaded
class PoiInit extends PoiEvent {
  const PoiInit(this.position);

  //This is for testing purposes!
  //The endpoint will need to be updated in the future
  final LatLng position;

  //final List<Map<String, dynamic>> allPois;

  @override
  List<Object> get props => [position];
}