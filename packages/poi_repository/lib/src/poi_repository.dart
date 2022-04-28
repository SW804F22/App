import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PoiRepository{

  Future<List> returnPois({required double lat, required double long, List<String>? categories}) async {

    String catString = "";
    if(categories != null){
      for(var cat in categories){
        catString += "category=$cat&";
      }
    }

    final response = await http.get(
        Uri.parse("http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?${catString}latitude="
            "$lat&longitude=$long&distance=0.5&limit=100"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

    if(response.statusCode == 404){
      return List.empty();
    }

    return json.decode(response.body) as List;
  }
}