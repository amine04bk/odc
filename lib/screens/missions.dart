import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:spacexview/screens/mission_details.dart';
import 'package:spacexview/screens/model.dart';

class MissionsList extends StatefulWidget {
  @override
  _MissionsListState createState() => _MissionsListState();
}

class _MissionsListState extends State<MissionsList> {
  late Future<List<Mission>> futureMissions;

  @override
  void initState() {
    super.initState();
    futureMissions = fetchMissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missions List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Mission>>(
        future: futureMissions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Failed to get data",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "No missions found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          } else {
            List<Mission> missions = snapshot.data!;
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
                  itemCount: missions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        missions[index].missionName,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () => _navigateToDetails(context, missions[index]),
                    );
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _navigateToDetails(BuildContext context, Mission mission) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MissionDetails(mission: mission),
      ),
    );
  }
}

Future<List<Mission>> fetchMissions() async {
  var cacheManager = DefaultCacheManager();
  FileInfo? cachedFile = await cacheManager.getFileFromCache('https://api.spacexdata.com/v3/missions');

  if (cachedFile != null) {
    // Use cached data if available
    var missionsData = json.decode(await cachedFile.file.readAsString());
    return List<Mission>.from(missionsData.map((x) => Mission.fromJson(x)));
  } else {
    // Fetch data from API and cache it
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      var missions = jsonResponse.map((mission) => Mission.fromJson(mission)).toList();

      // Cache mission data
      cacheManager.putFile('https://api.spacexdata.com/v3/missions', response.bodyBytes, key: 'https://api.spacexdata.com/v3/missions');

      return missions;
    } else {
      throw Exception('Failed to load missions');
    }
  }
}
