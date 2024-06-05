import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spacexview/screens/LoadingScreen.dart';








class missions extends StatefulWidget {
  
  @override
  _missions createState() => _missions();
}

class _missions extends State<missions> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      key: _scaffoldKey,
        appBar: AppBar(
        title: const Text(
          'MISSIONS',
          style: TextStyle(
              color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 16, 19, 65),
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/back-arrow.svg',
              height: 40,
              width: 40,
            ),
          ),
        ),
      ),
      
       
     body: Container(
      decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/mainback.jpg"),
            fit: BoxFit.cover,
            ),
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [

                    /////////  from api not done**** suposed to get it from api in hive 
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          'NASA and commercial crew provider SpaceX are targeting 2:49 a.m. EST Saturday, March 2, for the launch of the Demo-1 uncrewed flight test to the International Space Station. The uncrewed test flights will be the first time a commercially-built and operated American rocket and spacecraft designed for humans will launch to the space station.',
                          'description',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          '*****',
                          'description',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          '*****',
                          'description',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          '*****',
                          'description',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          '*****',
                          'description',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/demosat.jpg',
                          'DemoSat',
                          '*****',
                          'description',
                        ),
                ),



                  ],
                )
              ),
            ),
            
            ),
    );
  }
}

Widget laun(String path, String name, String date, String description) {
  return Container(
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 26, 30, 74),
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
                    width: (100),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
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
          bottom: 100,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 104, 35, 35),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
