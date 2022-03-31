import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bloc/poi_bloc.dart';

class PoiForm extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
        builder: (context, state){
          context.read<PoiBloc>().add(PoiInit(LatLng(55.67, 12.56)));
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Expanded(
                      child: state.allPois.isNotEmpty ? ListView.builder(
                        itemCount: state.allPois.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(state.allPois[index]['uuid']),
                          //color: Color(0xffececec),
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 7),
                          child: ExpansionTile (
                            leading: Text(
                              //Leading should be from recommendation tier
                              state.allPois[index]['title'].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            title: Text(state.allPois[index]['title']),
                            subtitle: state.allPois[index]['description'].isNotEmpty ?
                              Text('About: ${state.allPois[index]['description'].toString()}'
                              ) : const Text("No description available", style: TextStyle(fontSize: 12),),
                            collapsedBackgroundColor: Color(0xffececec),
                            collapsedTextColor: Colors.black,
                            textColor: Colors.black,
                            backgroundColor: Color(0xffececbb),
                            children: [
                              ListTile(
                                title: Text(state.allPois[index]['address']),
                                subtitle: Text(state.allPois[index]['website']),
                                tileColor: Colors.white,
                              )
                            ]
                          ),
                        )
                      ) : const Text('No results', style: TextStyle(fontSize: 24),)
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}