part of 'poi_bloc.dart';

abstract class PoiEvent extends Equatable {
  const PoiEvent();

  @override
  List<Object> get props => [];
}

//When the screen is first loaded
class PoiInit extends PoiEvent {
  const PoiInit(this.position);

  final LatLng position;

  @override
  List<Object> get props => [position];
}

// Load all categories
class CategoryInit extends PoiEvent {
  const CategoryInit();

  @override
  List<Object> get props => [];
}

// When the user wants to filter by category
class CategoryFilter extends PoiEvent {
  const CategoryFilter(this.categoriesFilter, this.position);

  final List<String> categoriesFilter;
  final LatLng position;

  @override
  List<Object> get props => [categoriesFilter, position];
}

// When the user searches for a poi name
class SearchPoi extends PoiEvent {
  const SearchPoi(this.searchQuery, this.position, this.categories);

  final String searchQuery;
  final LatLng position;
  final List<String> categories;

  @override
  List<Object> get props => [searchQuery, position, categories];
}
