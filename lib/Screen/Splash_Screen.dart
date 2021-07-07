import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project/Screen/Dashboard._Screen.dart';
import 'package:mini_project/Screen/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartUp extends StatefulWidget {
  // const StartUp({ Key? key }) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  void Pref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLogin") == true) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new PageDashboard()));
    } else {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new LoginPage()));
    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, Pref);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset('asset/images/logo.png'),
              new Padding(padding: new EdgeInsets.only(top: 25.0)),
              new CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
