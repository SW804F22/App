part of 'poi_bloc.dart';

abstract class PoiState extends Equatable {
  const PoiState();
}

class PoiInitial extends PoiState {
  @override
  List<Object> get props => [];
}
