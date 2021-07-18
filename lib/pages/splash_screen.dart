import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrreaderiasd/pages/home_page.dart';
import 'package:qrreaderiasd/utilitys/style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    openStartPage();
  }

  openStartPage() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgSplash,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: Center(child: Image.asset("assets/logo.png")),
            ),
          )
        ],
      ),
    );
  }
}
