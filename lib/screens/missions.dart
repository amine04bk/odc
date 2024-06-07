import 'dart:convert';
import 'dart:io';

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
        title: Text('Missions List'),
      ),
      body: Center(
        child: FutureBuilder<List<Mission>>(
          future: futureMissions,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No missions found");
            } else {
              List<Mission> missions = snapshot.data!;
              return ListView.builder(
                itemCount: missions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(missions[index].missionName),
                    onTap: () => _navigateToDetails(context, missions[index]),
                  );
                },
              );
            }
          },
        ),
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
  final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((mission) => Mission.fromJson(mission)).toList();
  } else {
    throw Exception('Failed to load missions');
  }
}
