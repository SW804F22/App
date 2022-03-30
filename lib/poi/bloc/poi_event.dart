part of 'poi_bloc.dart';

abstract class PoiEvent extends Equatable {
  const PoiEvent();

  @override
  List<Object> get props => [];
}

//When the screen is first loaded
class PoiInit extends PoiEvent {
  const PoiInit();

  //final List<Map<String, dynamic>> allPois;

  @override
  List<Object> get props => [];
}