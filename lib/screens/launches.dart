import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:spacexview/screens/model.dart';
import 'package:spacexview/screens/launch_detail_page.dart';


class LaunchListPage extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceX Launches'),
      ),
      body: FutureBuilder<List<Data>>(
        future: apiService.fetchLaunches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No launches found'));
          }

          final launches = snapshot.data!;

          return ListView.builder(
            itemCount: launches.length,
            itemBuilder: (context, index) {
              final launch = launches[index];
              return ListTile(
                leading: launch.links.missionPatchSmall != null
                    ? Image.network(launch.links.missionPatchSmall!)
                    : SizedBox.shrink(),
                title: Text(launch.missionName),
                subtitle: Text(launch.launchDateUtc.toString()),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LaunchDetailPage(launch: launch),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
