import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

part 'poi_event.dart';
part 'poi_state.dart';

class PoiBloc extends Bloc<PoiEvent, PoiState> {
  PoiBloc() : super(PoiState()) {
    on<PoiInit>(_onPoiInit);
    on<SearchQueryChanged>(_onSearchQueryChanged);
  }

  void _onPoiInit(
      PoiInit event,
      Emitter<PoiState> emit,) async
  {
    var pos = event.position;
    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?latitude="
            "${pos.latitude}&longitude=${pos.longitude}&distance=0.5&limit=100"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    List<Map<String, dynamic>> allPois = [];
    List resList = json.decode(response.body);
    //var map1 = Map.fromIterable(poiList, key: (e) => e.poi)
    for (var poi in resList) {
      allPois.add(
        {'uuid': poi['uuid'], 'title': poi['title'], 'description': poi['description'],
         'website': poi['website'], 'address': poi['address'], 'price': poi['priceStep']}
      );
    }

    emit(state.copyWith(
      allPois: allPois
    ));
  }

  void _onSearchQueryChanged(
      SearchQueryChanged event,
      Emitter<PoiState> emit,
      ) {
    print("Hello");
  }
}
