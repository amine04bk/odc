import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacexview/screens/LoadingScreen.dart';
import 'package:http/http.dart' as http;
import 'package:spacexview/screens/archi.dart';
import 'dart:convert';
import 'package:spacexview/screens/data.g.dart';









class launches extends StatefulWidget {
  @override
  _launches createState() => _launches();
}


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

class _launches extends State<launches> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
 
  @override
  void initState() {
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      
    );
  }
}
