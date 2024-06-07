import 'package:flutter/material.dart';
import 'package:spacexview/screens/model.dart';

class MissionDetails extends StatelessWidget {
  final Mission mission;

  MissionDetails({required this.mission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mission.missionName,
          style: TextStyle(color: Colors.white), // Text color
        ),
        backgroundColor: Colors.black, // App bar background color
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white, // Arrow color
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://img1.bjd.com.cn/2023/11/18/d648f9cd2daf58586694efc459aa2ffb57d9dd35.jpeg', // Background image URL
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.4), // Adjust opacity to create filter effect
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mission ID:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.missionId,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  const Text(
                    'Manufacturers:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.manufacturers.join(", "),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Payload IDs:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.payloadIds.join(", "),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Wikipedia:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.wikipedia,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Website:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.website,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  if (mission.twitter != null)
                    Text(
                      'Twitter:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  SizedBox(height: 8.0),
                  if (mission.twitter != null)
                    Text(
                      mission.twitter!,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  SizedBox(height: 16.0),
                  Text(
                    'Description:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    mission.description,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
