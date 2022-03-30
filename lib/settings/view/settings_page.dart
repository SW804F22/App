import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class SettingsPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage());
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:Center(child: const Text('Settings')),
          backgroundColor: Colors.deepPurple,
        ),
        body: (
           Center(
             child: ElevatedButton(
               child: const Text('Logout'),
               onPressed: () {
                 context
                     .read<AuthenticationBloc>()
                     .add(AuthenticationLogoutRequested());
               },
             ),
           )
        ),
      ),
    );
  }
}
