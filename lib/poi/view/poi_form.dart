import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/poi_bloc.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:poirecapi/global_styles.dart' as style;

class PoiFormTest extends StatelessWidget{
  const PoiFormTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      color: style.fourth,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _PoiFilterBar(),
              _PoiListView()
            ],
          ),
        ),
      ),
    );
  }
}

class _PoiFilterBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
      builder: (context, state){
        if(state.allCategories.isEmpty){
          context.read<PoiBloc>().add(CategoryInit());
        }
        return TextField(
          onChanged: (searchQuery) {
            context.read<PoiBloc>().add(SearchPoi(searchQuery, state.selectedCategories));
          },
          decoration: InputDecoration(
            hintText: 'Search location',
            suffixIcon: TextButton(
                onPressed: () => {
                  SelectDialog.showModal<String>(
                    context,
                    label: "Category filter",
                    searchBoxDecoration: InputDecoration(hintText: 'Search Category'),
                    alwaysShowScrollBar: true,
                    multipleSelectedValues: state.selectedCategories,
                    items: state.allCategories,
                    onMultipleItemsChange: (List<String> selected) {
                      context.read<PoiBloc>().add(CategoryFilter(selected));
                    },
                  )
                },
                child: Icon(Icons.filter_alt)
            ),
          ),
        );
      }
    );
  }
}

class _PoiListView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
      buildWhen: (previous, current) =>
        previous.allPois != current.allPois ||
        previous.position != current.position,
      builder: (context, state) {
        if(state.allPois.isEmpty){
          context.read<PoiBloc>().add(PoiInit());
        }
        return Expanded(
            child: state.allPois.isNotEmpty ? ListView.builder(
                itemCount: state.allPois.length,
                itemBuilder: (context, index) => Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 7),
                  child: ExpansionTile (
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
                        ),
                        ListTile(
                          title: Text(state.allPois[index]['category']),
                        )
                      ]
                  ),
                )
            ) : Text('No results', style: TextStyle(fontSize: style.fontBig),)
        );
      }
    );
  }
}

/*class PoiForm extends StatelessWidget{
  const PoiForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
        buildWhen: (previous, current) =>
          previous.allPois != current.allPois ||
          previous.allCategories != current.allCategories ||
          previous.position != current.position,
        builder: (context, state){
          if(state.allPois.isEmpty){
            context.read<PoiBloc>().add(PoiInit());
          }
          if(state.allCategories.isEmpty){
            context.read<PoiBloc>().add(CategoryInit());
          }
          print("State var: ${state.position}");
          return MaterialApp(
            color: style.fourth,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (searchQuery) {
                        context.read<PoiBloc>().add(SearchPoi(searchQuery, state.selectedCategories));
                      },
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        suffixIcon: TextButton(
                            onPressed: () => {
                              SelectDialog.showModal<String>(
                                context,
                                label: "Category filter",
                                searchBoxDecoration: InputDecoration(hintText: 'Search Category'),
                                alwaysShowScrollBar: true,
                                multipleSelectedValues: state.selectedCategories,
                                items: state.allCategories,
                                onMultipleItemsChange: (List<String> selected) {
                                  context.read<PoiBloc>().add(CategoryFilter(selected));
                                },
                              )
                            },
                            child: Icon(Icons.filter_alt)
                        ),
                      ),
                    ),
                    Expanded(
                        child: state.allPois.isNotEmpty ? ListView.builder(
                          itemCount: state.allPois.length,
                          itemBuilder: (context, index) => Card(
                          //color: Color(0xffececec),
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 7),
                          child: ExpansionTile (
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
                              ),
                              ListTile(
                                title: Text(state.allPois[index]['category']),
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
}*/
