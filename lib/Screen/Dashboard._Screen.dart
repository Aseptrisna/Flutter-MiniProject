import 'package:flutter/material.dart';
import 'package:mini_project/Screen/Camera_Screen.dart';
import 'package:mini_project/Screen/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mini_project/Screen/Camera_Screen.dart';
// import 'package:camera/camera.dart';
// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// WidgetsFlutterBinding.ensureInitialized();
// final cameras = await availableCameras();
// final firstCamera = cameras.first;

class PageDashboard extends StatelessWidget {
  // final cameras = await availableCameras();

  // // Get a specific camera from the list of available cameras.
  // final firstCamera = cameras.first;
  Future<void> Logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.all(25.0),
          //       child: Container(
          //         width: 100,
          //         height: 100,
          //         child: Image.asset("asset/images/user.png"),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.all(20.0),
          //       child: Container(
          //         width: 100,
          //         height: 100,
          //         child: Image.asset("asset/images/user.png"),
          //       ),
          //     )
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(10.0),
              // ),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Profile"),
                    onPressed: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Profile()),
                      // )
                    },
                    splashColor: Colors.redAccent,
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Report"),
                    onPressed: () => {
                      mainCamera()
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => new TakePictureScreen(camera: camera)),
                      // )
                    },
                    splashColor: Colors.redAccent,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Settings"),
                    onPressed: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Settings()),
                      // )
                    },
                    splashColor: Colors.redAccent,
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Keluar"),
                    onPressed: () => {
                      Logout(),
                      //  Logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      )
                    },
                    splashColor: Colors.redAccent,
                  )),
            ],
          ),
        ],
      )),
    );
  }
}

// Logout() {
// }
