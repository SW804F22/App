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
    on<CategoryInit>(_onCategoryInit);
    on<CategoryFilter>(_onCategoryFilter);
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
    for (var poi in resList) {
      String categoriesString = "";
      for(var categories in poi['categories']){
        categoriesString += categories + ", ";
      }
      allPois.add(
        {'uuid': poi['uuid'], 'title': poi['title'], 'description': poi['description'], 'category': categoriesString,
         'website': poi['website'], 'address': poi['address'], 'price': poi['priceStep']}
      );
    }

    emit(state.copyWith(
      allPois: allPois
    ));
  }

  void _onCategoryInit(
      CategoryInit event,
      Emitter<PoiState> emit
      ) async {

    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/Category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    List<String> categories = json.decode(response.body).cast<String>();

    emit(state.copyWith(
      categories: categories
    ));
  }

  void _onCategoryFilter(
      CategoryFilter event,
      Emitter<PoiState> emit
      ) async {

    var pos = event.position;
    List<String> cats = event.categoriesFilter;
    String catString = "";

    for(var cat in cats){
      catString += "category=$cat&";
    }

    print(catString);
    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?${catString}latitude="
            "${pos.latitude}&longitude=${pos.longitude}&distance=0.5&limit=100"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    List<Map<String, dynamic>> allPois = [];
    List resList = json.decode(response.body);
    for (var poi in resList) {
      String categoriesString = "";
      for(var categories in poi['categories']){
        categoriesString += categories + ", ";
      }
      allPois.add(
          {'uuid': poi['uuid'], 'title': poi['title'], 'description': poi['description'], 'category': categoriesString,
            'website': poi['website'], 'address': poi['address'], 'price': poi['priceStep']}
      );
    }

    emit(state.copyWith(
      allPois: allPois
    ));
  }
}
