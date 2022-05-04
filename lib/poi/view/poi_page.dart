import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_repository/maps_repository.dart';
import 'package:poi_repository/poi_repository.dart';
import 'package:poirecapi/global_styles.dart' as style;

import '../bloc/poi_bloc.dart';
import 'poi_form.dart';

class PoiPage extends StatelessWidget {
  const PoiPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PoiPage());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Your Recommendations')),
        backgroundColor: style.primary,
      ),
      body: BlocProvider(
        create: (context) {
          return PoiBloc(
            poiRepository:
              RepositoryProvider.of<PoiRepository>(context),
            mapsRepository:
              RepositoryProvider.of<MapsRepository>(context)
          );
        },
        child: PoiFormTest(),
      )
    );
  }
}