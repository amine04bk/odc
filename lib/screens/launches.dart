import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacexview/screens/LoadingScreen.dart';
import 'package:http/http.dart' as http;
import 'package:spacexview/screens/archi.dart';
import 'dart:convert';









class launches extends StatefulWidget {
  @override
  _launches createState() => _launches();
}

class _launches extends State<launches> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
 
  @override
  void initState() {
    super.initState();
    _getData();
  }
 
  Data? dataFromAPI;
  _getData() async {
    ///// wait for the api  response to fetch data in the model data.dart 
    try {
      String url = "https://api.spacexdata.com/v4/launches";
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        dataFromAPI = Data.fromJson(json.decode(res.body));
        _isLoading = false;
        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //// not work api not response ********
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        dataFromAPI!.links.patch.small,
                        width: 100,
                      ),
                    ]
                  ),
                );
              },
              itemCount: dataFromAPI!.id.length,
            ),
    );
  }
}

Widget laun(String path, String name, String date, String description) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF5D6290),
      borderRadius: BorderRadius.circular(10),
    ),
    width: 600,

    child: Stack(
      children: [

        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Image.asset(
                    path,
                    width: (140),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                  SizedBox(height: 3),
                  Text(
                    date,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 35,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: 80,
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 104, 35, 35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
