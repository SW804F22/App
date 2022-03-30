import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poirecapi/login/login.dart';

import '../bloc/map_bloc.dart';
import 'map_form.dart';

class MapPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MapPage());
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Center(child: const Text('Maps')),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocProvider(
        create: (context) {
      return MapBloc();
    },
    child: MapForm(),
    ),
    );
  }
}
