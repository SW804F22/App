import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poirecapi/GlobalStyles.dart' as style;

import '../bloc/poi_bloc.dart';
import 'poi_form.dart';

class PoiPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PoiPage());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Your recommendations')),
        backgroundColor: style.primary,
      ),
      body: BlocProvider(
        create: (context) {
          return PoiBloc();
        },
        child: PoiForm(),
      ),
    );
  }
}