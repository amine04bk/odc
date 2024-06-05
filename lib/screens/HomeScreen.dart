import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacexview/screens/LoadingScreen.dart';
import 'package:spacexview/screens/launches.dart';
import 'package:spacexview/screens/missions.dart';








class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      key: _scaffoldKey,
     body: Container(
      decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/mainback.jpg"),
            fit: BoxFit.cover,
            ),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 100.0),

                Container(

                  
                  child: Image.asset(
                        'assets/logom.png',
                        height: 35,
                      ),
                  
                ),
                 SizedBox(height: 210.0),

                Container(
                       child: Padding(
                        padding: EdgeInsets.fromLTRB(35, 0, 30, 0),
                        child:   Row(
                          children: [
                            Column(
                              children: [
                        GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => missions()),
                      );
                    },
                child: Image.asset(
                  'assets/missions.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                ),
                  ),
                      ],
                            ),
                           Column(
                              children: [
                        GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => launches()),
                      );
                    },
                child: Image.asset(
                  'assets/LAUNCHES.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                ),
                  ),
                      ],
                            ),
                         
                          ],
                        ),
                     
                      ),
               
                ),
                






                ],
              ),
            ),
            
      ),
    );
  }
}
