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
    futureLaunches = fetchLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Wrap with Container
      color: Colors.black, // Set background color to black
      child: Scaffold(
        appBar: AppBar(
          title: Text('SpaceX Launches', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(isSortedAscending ? Icons.arrow_downward : Icons.arrow_upward),
              onPressed: sortLaunches,
              color: Colors.white,
            )
          ],
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder<List<Launch>>(
              future: futureLaunches,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}", style: TextStyle(color: Colors.white));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text("No launches found", style: TextStyle(color: Colors.white));
                } else {
                  launches = snapshot.data!;
                  return ListView.builder(
                    itemCount: launches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0), // Remove padding
                        title: Text(
                          launches[index].missionName,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        subtitle: Text(
                          'Launch Year: ${launches[index].launchYear}',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () => _navigateToDetails(context, launches[index]),
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

Future<List<Launch>> fetchLaunches() async {
  var cacheManager = DefaultCacheManager();
  FileInfo? cachedFile = await cacheManager.getFileFromCache('launches_data');

  if (cachedFile != null) {
    // Use cached data if available
    var launchesData = json.decode(await cachedFile.file.readAsString());
    return List<Launch>.from(launchesData.map((x) => Launch.fromJson(x)));
  } else {
    // Fetch data from API and cache it
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/launches'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var launches = jsonResponse.map((launch) => Launch.fromJson(launch)).toList();

      // Cache launch data
      cacheManager.putFile('https://api.spacexdata.com/v3/launches', response.bodyBytes, key: 'launches_data');

      return launches;
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
