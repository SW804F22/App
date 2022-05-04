import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapsRepository{
  var position = LatLng(0, 0);

  Future<List> returnMarkers({required double lat, required double long}) async {
    position = new LatLng(lat, long);
    print("Repo var: $position");

    final response = await http.get(
        Uri.parse('http://poirecserver.swedencentral.cloudapp.azure.com/Poi/search?latitude=$lat&longitude=$long&distance=0.01&limit=1000'),
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