import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'poi_event.dart';
part 'poi_state.dart';

class PoiBloc extends Bloc<PoiEvent, PoiState> {
  PoiBloc() : super(PoiInitial()) {
    on<PoiEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
