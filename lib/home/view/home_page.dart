import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/map/view/map_page.dart';
import 'package:flutter_login/settings/view/settings_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../authentication/bloc/authentication_bloc.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  static List<Widget> _pages = <Widget>[
    Icon(
      Icons.pin_drop,
      size: 150,
    ),
    MapPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
            selectedItemColor: Colors.deepPurple,
            items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.pin_drop), label: 'Recommended'),
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

}
