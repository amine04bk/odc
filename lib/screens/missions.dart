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
                          'details',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/falcon5.jpg',
                          'Falcon5',
                          'The Falcon 5 significantly increased the capability of the Falcon family, with a capacity of over 9,200 pounds to low orbit and up to a 13.1 foot (4 meter) diameter payload fairing. The larger Falcon 5 was to use 5 SpaceX-developed Merlin engines in the first stage with an engine-out capability to enhance reliability.',
                          'details',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/falcon9.jpg',
                          'Falcon9',
                          'Falcon 9 is a reusable, two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of people and payloads into Earth orbit and beyond. Falcon 9 is the world’s first orbital class reusable rocket.',
                          'details',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/f9d.jpg',
                          'Falcon 9 Dragon',
                          'Falcon 9 is a reusable, two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of people and payloads into Earth orbit and beyond. Falcon 9 is the world’s first orbital class reusable rocket.',
                          'details',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/crs1.jpg',
                          'CRS-1',
                          "SpaceX CRS-1, also known as SpX-1,[8] was SpaceX's first operational cargo mission to the International Space Station, under their Commercial Resupply Services (CRS-1) contract with NASA. It was the third flight for the uncrewed Dragon cargo spacecraft, and the fourth overall flight for the company's two-stage Falcon 9 launch vehicle. The launch occurred on 8 October 2012 at 00:34:07 UTC.",
                          'details',
                        ),
                ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: laun(
                          'assets/crs2.jpg',
                          'CRS-2',
                          "SpaceX CRS-2, also known as SpX-2,[6] was the fourth flight for SpaceX's uncrewed Dragon cargo spacecraft, the fifth and final flight for the company's two-stage Falcon 9 v1.0 launch vehicle, and the second SpaceX operational mission contracted to NASA under a Commercial Resupply Services (CRS-1) contract.",
                          'details',
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
