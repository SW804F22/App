import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_repository/maps_repository.dart';
import 'package:poi_repository/poi_repository.dart';

part 'poi_event.dart';
part 'poi_state.dart';

class PoiBloc extends Bloc<PoiEvent, PoiState> {
  PoiBloc({
    required PoiRepository poiRepository,
    required MapsRepository mapsRepository,
  }) : _poiRepository = poiRepository,
       _mapsRepository = mapsRepository,
        super(PoiState()) {
    on<PoiInit>(_onPoiInit);
    on<CategoryInit>(_onCategoryInit);
    on<CategoryFilter>(_onCategoryFilter);
    on<SearchPoi>(_onSearchPoi);
  }

  final PoiRepository _poiRepository;
  final MapsRepository _mapsRepository;

  void _onPoiInit(
      PoiInit event,
      Emitter<PoiState> emit,) async
  {
    var pos = _mapsRepository.position;
    List<Map<String, dynamic>> allPois = [];
    List resList = await _poiRepository.returnPois(lat: pos.latitude, long: pos.longitude);
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
      allPois: allPois,
      position: pos,
    ));
  }

  void _onCategoryInit(
      CategoryInit event,
      Emitter<PoiState> emit
      ) async {

    final List<String >categories = await _poiRepository.returnCategories();

    emit(state.copyWith(
      allCategories: categories
    ));
  }

  void _onCategoryFilter(
      CategoryFilter event,
      Emitter<PoiState> emit
      ) async {

    var pos = _mapsRepository.position;

    List<Map<String, dynamic>> allPois = [];
    List resList = await _poiRepository.returnPois(
        lat: pos.latitude,
        long: pos.longitude,
        categories: event.categoriesFilter,
    );

    for (var poi in resList) {
      String categoriesString = "";
      for(var categories in poi['categories']){
        categoriesString += categories + ", ";
      }
      allPois.add(
          {'uuid': poi['uuid'], 'title': poi['title'],
           'description': poi['description'], 'category': categoriesString,
           'website': poi['website'], 'address': poi['address'], 'price': poi['priceStep']}
      );
    }

    emit(state.copyWith(
      allPois: allPois,
      selectedCategories: event.categoriesFilter,
      position: pos
    ));
  }

  void _onSearchPoi(
      SearchPoi event,
      Emitter<PoiState> emit
      ) async {

    var searchQuery = event.searchQuery;
    var pos = _mapsRepository.position;

    List<Map<String, dynamic>> allPois = [];
    List resList = await _poiRepository.returnPois(
      lat: pos.latitude,
      long: pos.longitude,
      search: searchQuery,
      categories: event.categories.isNotEmpty ? event.categories : null
    );

    // Format the data to fit the flutter widget
    for (var poi in resList) {
      String categoriesString = "";
      for(var categories in poi['categories']){
        categoriesString += categories + ", ";
      }
      allPois.add(
          {'uuid': poi['uuid'], 'title': poi['title'],
            'description': poi['description'], 'category': categoriesString,
            'website': poi['website'], 'address': poi['address'], 'price': poi['priceStep']}
      );
    }

    emit(state.copyWith(
      allPois: allPois,
      position: pos
    ));
  }
}
