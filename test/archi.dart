class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SpaceX Data')),
        body: FutureBuilder(
          future: fetchAndStoreData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              return ValueListenableBuilder(
                valueListenable: Hive.box<Data>('dataBox').listenable(),
                builder: (context, Box<Data> box, _) {
                  if (box.values.isEmpty) {
                    return Center(child: Text('No data'));
                  }
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Data data = box.getAt(index);
                      return ListTile(
                        title: Text(data.name),
                        subtitle: Text(data.details),
                      );
                    },
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';

Future<void> fetchAndStoreData() async {
  final response = await http.get(Uri.parse('https://api.spacexdata.com/v4/launches'));
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    var box = await Hive.openBox<Data>('dataBox');
    for (var item in jsonData) {
      Data data = Data.fromJson(item);
      box.add(data);
    }
  } else {
    throw Exception('Failed to load data');
  }
}
