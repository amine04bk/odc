import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:spacexview/screens/LaunchDetail.dart';
import 'package:spacexview/screens/model.dart';



class LaunchList extends StatefulWidget {
  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  late Future<List<Launch>> futureLaunches;
  List<Launch> launches = [];
  bool isSortedAscending = true;

  @override
  void initState() {
    super.initState();
    futureLaunches = fetchLaunchesFromAPI();
    cacheAllImages(); // Call function to cache all images at app startup
  }

  Future<void> cacheAllImages() async {
    // Fetch all launches and cache their images
    List<Launch> allLaunches = await fetchLaunchesFromAPI();
    for (var launch in allLaunches) {
      if (launch.missionPatch.isNotEmpty) {
        await DefaultCacheManager().getSingleFile(launch.missionPatch);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Launches'),
        actions: [
          IconButton(
            icon: Icon(isSortedAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: sortLaunches,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mainback.png'), // Background image
            fit: BoxFit.,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.all(16.0),
              child: Center(
          child: FutureBuilder<List<Launch>>(
            future: futureLaunches,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Text("No launches found");
              } else {
                launches = snapshot.data!;
                return ListView.builder(
                  itemCount: launches.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.black, // Background color of each list item
                      margin: EdgeInsets.symmetric(vertical: 4),
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        leading: launches[index].missionPatch.isNotEmpty
                            ? FutureBuilder<File>(
                                future: DefaultCacheManager().getSingleFile(launches[index].missionPatch),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done &&
                                      snapshot.hasData &&
                                      snapshot.data != null) {
                                    return Image.file(snapshot.data!);
                                  } else {
                                    return Icon(Icons.image_not_supported);
                                  }
                                },
                              )
                            : Icon(Icons.image_not_supported),
                                title: Text(
                                  launches[index].missionName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Launch Year: ${launches[index].launchYear}',
                                  style: TextStyle(color: Colors.white),
                                ),

                        onTap: () => _navigateToDetails(context, launches[index]),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      

        ),
      ),
    );
  }

  void sortLaunches() {
    setState(() {
      if (isSortedAscending) {
        launches.sort((a, b) => a.launchDate.compareTo(b.launchDate));
      } else {
        launches.sort((a, b) => b.launchDate.compareTo(a.launchDate));
      }
      isSortedAscending = !isSortedAscending;
    });
  }

  void _navigateToDetails(BuildContext context, Launch launch) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaunchDetail(launch: launch),
      ),
    );
  }
}

Future<List<Launch>> fetchLaunchesFromAPI() async {
  final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/launches'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((launch) => Launch.fromJson(launch)).toList();
  } else {
    throw Exception('Failed to load launches');
  }
}

