import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/map/view/map_page.dart';
import 'package:flutter_login/poi/view/poi_page.dart';
import 'package:flutter_login/settings/view/settings_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../authentication/bloc/authentication_bloc.dart';
import 'package:flutter_login/GlobalStyles.dart' as style;

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
    PoiPage(),
    MapPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
            backgroundColor: style.primary,
            unselectedItemColor: style.secondary,
            selectedItemColor: style.fourth,
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
