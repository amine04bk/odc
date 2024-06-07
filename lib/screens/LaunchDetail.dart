import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:spacexview/screens/model.dart';


class LaunchDetail extends StatelessWidget {
  final Launch launch;

  LaunchDetail({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(launch.missionName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            launch.missionPatch.isNotEmpty
                ? FutureBuilder<File>(
                    future: DefaultCacheManager().getSingleFile(launch.missionPatch),
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
            SizedBox(height: 8.0),
            Text('Mission Name: ${launch.missionName}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Launch Year: ${launch.launchYear}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Launch Date: ${launch.launchDate.toLocal()}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Details: ${launch.details}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Text('Launch Success: ${launch.launchSuccess ? "Yes" : "No"}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
