import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/poi_bloc.dart';

class PoiForm extends StatelessWidget{
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  @override
  Widget build(BuildContext context){
    return BlocBuilder<PoiBloc, PoiState>(
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: _allUsers.isNotEmpty ? ListView.builder(
                        itemCount: _allUsers.length,
                        itemBuilder: (context, index) => Card(
                          key: ValueKey(_allUsers[index]['id']),
                          color: Colors.amberAccent,
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: Text(
                              _allUsers[index]['id'].toString(),
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(_allUsers[index]['name']),
                            subtitle: Text(
                                '${_allUsers[index]["age"].toString()} years old'
                            ),
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