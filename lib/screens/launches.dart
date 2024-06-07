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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureLaunches = fetchLaunches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Launches', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(isSortedAscending ? Icons.arrow_downward : Icons.arrow_upward),
            onPressed: sortLaunches,
            color: Colors.white,
          )
        ],
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
  padding: const EdgeInsets.all(0),
  child: Container(
    color: Colors.black,
    child: TextField(
      controller: searchController,
      onChanged: filterLaunches,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search by mission name',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  ),
),

          Expanded(
            child: FutureBuilder<List<Launch>>(
              future: futureLaunches,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text("No launches found", style: TextStyle(color: Colors.white));
                } else {
                  launches = snapshot.data!;
                  return Stack(
                      children: [
                      Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://img1.bjd.com.cn/2023/11/18/d648f9cd2daf58586694efc459aa2ffb57d9dd35.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.4,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                ListView.builder(
                    itemCount: launches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          subtitle: Text(
                            'Launch Year: ${launches[index].launchYear}',
                            style: TextStyle(color: Colors.white),
                          ),
                          onTap: () => _navigateToDetails(context, launches[index]),
                        );
                      
                    },
                  )
                


                      ],
                  );
                  }
              },
            ),
          ),
        ],
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

  void filterLaunches(String query) {
    setState(() {
      futureLaunches = fetchLaunches(searchQuery: query);
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

Future<List<Launch>> fetchLaunches({String? searchQuery}) async {
  var cacheManager = DefaultCacheManager();
  FileInfo? cachedFile = await cacheManager.getFileFromCache('launches_data');

  if (cachedFile != null) {
    // Use cached data if available
    var launchesData = json.decode(await cachedFile.file.readAsString());
    List<Launch> launches = List<Launch>.from(launchesData.map((x) => Launch.fromJson(x)));

    if (searchQuery != null && searchQuery.isNotEmpty) {
      // Filter launches based on search query
      launches = launches.where((launch) => launch.missionName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return launches;
  } else {
    // Fetch data from API and cache it
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/launches'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var launches = jsonResponse.map((launch) => Launch.fromJson(launch)).toList();

      // Cache launch data
      cacheManager.putFile('https://api.spacexdata.com/v3/launches', response.bodyBytes, key: 'launches_data');

      if (searchQuery != null && searchQuery.isNotEmpty) {
        // Filter launches based on search query
        launches = launches.where((launch) => launch.missionName.toLowerCase().contains(searchQuery.toLowerCase())).toList();
      }

      return launches;
    } else {
      throw Exception('Failed to load launches');
    }
  }
}
