import 'package:flutter/material.dart';
import 'package:poirecapi/map/view/map_page.dart';
import 'package:poirecapi/settings/view/settings_main.dart';
import 'package:poirecapi/poi/view/poi_page.dart';
import 'package:poirecapi/global_styles.dart' as style;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  static final List<Widget> _pages = <Widget>[
    PoiPage(),
    MapPage(),
    SettingsMain(),
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
            items: const <BottomNavigationBarItem>[
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
      if(index == 0){
        //PUSH THE POI PAGE
        Navigator.of(context).push<void>(
            PoiPage.route()
        );
      }
      else{
        _selectedIndex = index;
      }
    });
  }

}
