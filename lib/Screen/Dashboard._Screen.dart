import 'package:flutter/material.dart';

class PageDashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("asset/images/user.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("asset/images/user.png"),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.all(10.0),
              // ),
              Padding(
                  padding: EdgeInsets.all(20.0),
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
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("Menu"),
                    onPressed: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Menu()),
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
                  padding: EdgeInsets.all(20.0),
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
                  padding: EdgeInsets.all(20.0),
                  child: new MaterialButton(
                    height: 100.0,
                    minWidth: 150.0,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: new Text("About"),
                    onPressed: () => {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => About()),
                      // )
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
