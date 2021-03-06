import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoiRepository{

  var position = LatLng(55.6833, 12.5810);

  //Returns a list of all pois based on location and categories
  Future<List> returnPois({required double lat, required double long,
                           List<String>? categories, String? search})
  async {
    // Category query
    String catString = "";
    if(categories != null){
      for(var cat in categories){
        catString += "category=$cat&";
      }
    }

    // Search query
    String searchString = "";
    if(search != null){
      searchString = search;
    }

    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?name=$searchString&"
            "${catString}latitude=${position.latitude}&longitude=${position.longitude}&distance=0.01&limit=50"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if(response.statusCode == 404){
      return List.empty();
    }

    return json.decode(response.body) as List;
  }

  //Returns a list of all categories
  Future<List<String>> returnCategories() async {
    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/Category"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    List<String> categories = json.decode(response.body).cast<String>();

    return categories;
  }
}