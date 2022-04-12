import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_choices/search_choices.dart';
import '../bloc/poi_bloc.dart';
import 'package:poirecapi/global_styles.dart' as style;

class PoiForm extends StatelessWidget{
  const PoiForm({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
        buildWhen: (previous, current) => previous.allPois != current.allPois,
        builder: (context, state){
          context.read<PoiBloc>().add(PoiInit(LatLng(55.67, 12.56)));
          return MaterialApp(
            color: style.fourth,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    _FilterBar(),
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
                              style: TextStyle(fontSize: style.fontMedium),
                            ),
                            title: Text(state.allPois[index]['title']),
                            subtitle: state.allPois[index]['description'].isNotEmpty ?
                              Text('About: ${state.allPois[index]['description'].toString()}'
                              ) : Text("No description available", style: TextStyle(fontSize: style.fontSmall),),
                            collapsedBackgroundColor: style.tertiary,
                            collapsedTextColor: Colors.black,
                            textColor: Colors.black,
                            backgroundColor: style.secondary,
                            children: [
                              ListTile(
                                title: Text(state.allPois[index]['address']),
                                subtitle: Text(state.allPois[index]['website']),
                              )
                            ]
                          ),
                        )
                      ) : Text('No results', style: TextStyle(fontSize: style.fontBig),)
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

class _FilterBar extends StatelessWidget {
  final items = [DropdownMenuItem(child: Text('test')), DropdownMenuItem(child: Text('test 2'))];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PoiBloc, PoiState>(
        builder: (context, state) {
          return SearchChoices.multiple(
            items: items,
            selectedItems: [],
            hint: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('Select any'),
            ),
            searchHint: "Select any",
            onChanged: (value) {print('hello friend');},
            dialogBox: false,
            closeButton: (selectedItemsClose, closeContext, Function updateParent) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: (){
                        selectedItemsClose.clear();
                        selectedItemsClose.addAll(
                          Iterable<int>.generate(items.length).toList());
                        updateParent(selectedItemsClose);
                      },
                      child: Text('Select All')),
                  ElevatedButton(
                      onPressed: () {
                        selectedItemsClose.clear();
                        updateParent(selectedItemsClose);
                      },
                      child: Text('Select none'))
                ],
              );
             },
            isExpanded: true,
            menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
          );
        }
    );
  }
}
