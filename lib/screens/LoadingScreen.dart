import 'package:flutter/material.dart';
import 'package:spacexview/screens/HomeScreen.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingScreen(),
  ));
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _redirectToHome();
  }

  void _redirectToHome() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomePage(),
          transitionsBuilder: (context, animation1, animation2, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation1.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 700),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/backloading.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 220,
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
