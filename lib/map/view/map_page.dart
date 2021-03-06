import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_repository/maps_repository.dart';
import 'package:poi_repository/poi_repository.dart';
import 'package:poirecapi/global_styles.dart' as style;

import '../bloc/map_bloc.dart';
import 'map_form.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MapPage());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Center(child: const Text('Maps')),
        backgroundColor: style.primary,
      ),
      body: BlocProvider(
        create: (context) {
          return MapBloc(
            mapsRepository:
              RepositoryProvider.of<MapsRepository>(context),
            poiRepository:
              RepositoryProvider.of<PoiRepository>(context)
          );
        },
    child: MapForm(),
    ),
    );
  }
}
