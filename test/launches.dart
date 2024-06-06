import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:spacexview/screens/model.dart';
import 'dart:convert';

class Launches extends StatefulWidget {
  @override
  _LaunchesState createState() => _LaunchesState();
}

class _LaunchesState extends State<Launches> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  List<Data>? launches;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    http.Response response = await http.get(Uri.parse("https://api.spacexdata.com/v3/launches"));

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        launches = dataFromJson(response.body);
        _isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: launches?.length ?? 0,
              itemBuilder: (context, index) {
                final launch = launches![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      launch.links?.patch?.small != null
                          ? Image.network(
                              launch.links!.patch!.small!,
                              width: 100,
                            )
                          : Container(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            launch.name ?? "N/A",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            launch.dateUtc != null ? launch.dateUtc!.toIso8601String() : "N/A",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
