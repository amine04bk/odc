import 'package:flutter/material.dart';
import 'package:spacexview/screens/model.dart';

class MissionDetails extends StatelessWidget {
  final Mission mission;

  MissionDetails({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mission.missionName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mission ID: ${mission.missionId}'),
            SizedBox(height: 8.0),
            Text('Manufacturers: ${mission.manufacturers.join(", ")}'),
            SizedBox(height: 8.0),
            Text('Payload IDs: ${mission.payloadIds.join(", ")}'),
            SizedBox(height: 8.0),
            Text('Wikipedia: ${mission.wikipedia}'),
            SizedBox(height: 8.0),
            Text('Website: ${mission.website}'),
            SizedBox(height: 8.0),
            if (mission.twitter != null) Text('Twitter: ${mission.twitter}'),
            SizedBox(height: 8.0),
            Text('Description: ${mission.description}'),
          ],
        ),
      ),
    );
  }
}
