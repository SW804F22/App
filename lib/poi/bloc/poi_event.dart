part of 'poi_bloc.dart';

abstract class PoiEvent extends Equatable {
  const PoiEvent();

  @override
  List<Object> get props => [];
}

//When the screen is first loaded
class PoiInit extends PoiEvent {
  const PoiInit();

  @override
  List<Object> get props => [];
}

// Load all categories
class CategoryInit extends PoiEvent {
  const CategoryInit();

  @override
  List<Object> get props => [];
}

// When the user wants to filter by category
class CategoryFilter extends PoiEvent {
  const CategoryFilter(this.categoriesFilter);

  final List<String> categoriesFilter;

  @override
  List<Object> get props => [categoriesFilter];
}

// When the user searches for a poi name
class SearchPoi extends PoiEvent {
  const SearchPoi(this.searchQuery, this.categories);

  final String searchQuery;
  final List<String> categories;

  @override
  List<Object> get props => [searchQuery, categories];
}
