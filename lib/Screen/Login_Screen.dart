import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project/Common/dialog.dart';
import 'package:mini_project/Screen/Dashboard._Screen.dart';
import 'package:mini_project/Screen/Signup_Screen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mini_project/Server/Server.dart';
import 'package:mini_project/Common/color.dart';
import 'package:mini_project/Common/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> Signin() async {
    var url = UrlServer + "user/signin";
    final response = await http.post(Uri.parse(url), body: {
      "email": controlleremail.text,
      "password": controllerpassword.text
    });
    String email = controlleremail.text;
    String password = controllerpassword.text;
    if (email.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Email Tidak Kosong !', ErrorColor);
    } else if (password.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Nama Tidak Kosong !', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "email": controlleremail.text,
        "password": controllerpassword.text
      });
      var result = convert.jsonDecode(response.body);
      // var simpan = Simpan(result);
      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('id', result['_id']);
        await prefs.setString('nama', result['nama']);
        await prefs.setString('email', result['email']);
        await prefs.setString('telp', result['telp']);
        await prefs.setString('password', result['password']);

        var _duration = new Duration(seconds: 1);
        new Timer(_duration, () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new PageDashboard()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
    }

    // Future<void> Simpan(result) async {}
    // void Simpanuser(){

    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 15),
              child: Center(
                child: Container(
                    width: 150,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('asset/images/user.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  'Masuk',
                  style: (TextStyle(
                      color: Colors.blue, fontSize: 25, fontFamily: 'Raleway')),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0))),
                    labelText: 'Email',
                    hintText: 'Masukan Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerpassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0))),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            // FlatButton(
            //   onPressed: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            // child: Text(
            //   'Forgot Password',
            //   style: TextStyle(color: Colors.blue, fontSize: 15),
            // ),
            // ),
            Container(
              // padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20.0),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () {
                  Submit(context);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'MASUK',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignupPage()));
                },
                child: Text(
                  'Belum Punya Akun? Daftar',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                )),
            // Text('Belum Punya Akun? Daftar')
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      Signin();
    } catch (error) {
      print(error);
    }
  }
}
