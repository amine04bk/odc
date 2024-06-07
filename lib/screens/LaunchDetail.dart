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
        title: Text(launch.missionName,
          style: TextStyle(color: Colors.white),),
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
          padding: EdgeInsets.all(30.0),
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
              SizedBox(height: 30.0),
              Text('Mission Name: ${launch.missionName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8.0),
              Text('Launch Year: ${launch.launchYear}', style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 8.0),
              Text('Launch Date: ${launch.launchDate.toLocal()}', style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 8.0),
              Text('Details: ${launch.details}', style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 8.0),
              Text('Launch Success: ${launch.launchSuccess ? "Yes" : "No"}', style: TextStyle(fontSize: 20, color: Colors.white)),

              ],
          ),
        ),
       ),
        ],
      ),
    
    );
  }
}
