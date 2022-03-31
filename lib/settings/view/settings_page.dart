import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/GlobalStyles.dart' as style;
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
          backgroundColor: style.primary,
        ),
        body: (
           Center(
             child: ElevatedButton(
               style: ElevatedButton.styleFrom(primary: style.primary),
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
