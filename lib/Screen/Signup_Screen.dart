/*
Bandung 07-07-2021
Asep Trisna Setiawan
Bismillah TMDG 2021
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project/Common/color.dart';
import 'package:mini_project/Common/dialog.dart';
import 'package:mini_project/Screen/Login_Screen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mini_project/Server/Server.dart';
import 'package:mini_project/Service/guid_service.dart';
import 'package:uuid/uuid.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySignup(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySignup extends StatefulWidget {
  // const MySignup({Key? key}) : super(key: key);

  @override
  _MySignupState createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  final GuidService guidService = new GuidService();
  TextEditingController controlleremail = new TextEditingController();
  TextEditingController controllernama = new TextEditingController();
  TextEditingController controllertelp = new TextEditingController();
  TextEditingController controllerpassword = new TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // var uuid = Uuid();
  Future<void> Signup() async {
    // print(GuidService().generateGuid());
    var url = UrlServer + "user/signup";
    String email = controlleremail.text;
    String nama = controllernama.text;
    String telp = controllertelp.text;
    String password = controllerpassword.text;
    if (email.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Email Tidak Kosong !', ErrorColor);
    } else if (nama.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Nama Tidak Kosong !', ErrorColor);
    } else if (telp.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Telpon Tidak Kosong !', ErrorColor);
    } else if (password.isEmpty) {
      Navigator.of(context, rootNavigator: true).pop();
      showSnakbar(context, 'Kolom Password Tidak Kosong !', ErrorColor);
    } else {
      final response = await http.post(Uri.parse(url), body: {
        "guid_id": GuidService().generateGuid(),
        "email": controlleremail.text,
        "nama": controllernama.text,
        "telp": controllertelp.text,
        "password": controllerpassword.text
      });
      var result = convert.jsonDecode(response.body);
      String Message = result['message'];
      if (result['status']) {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, SuccesColor);
        print(Message);
        var _duration = new Duration(seconds: 1);
        new Timer(_duration, () {
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => new LoginPage()));
        });
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        showSnakbar(context, Message, ErrorColor);
        print(Message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // new Form(child: null,),
            Padding(
              padding: const EdgeInsets.only(top: 60, bottom: 15),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("asset/images/user.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Daftar Akun',
                style: TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controlleremail,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Email',
                    hintText: 'Masukan Email '),
                // controller: contr,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controllernama,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Nama',
                    hintText: 'Masukan Nama'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controllertelp,
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Nomor Telpon',
                    hintText: 'Masukan Nomor telpon'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: controllerpassword,
                autofocus: true,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Password',
                    hintText: 'Masukan Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                margin: const EdgeInsets.all(10),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    Submit(context);
                  },
                  child: Text(
                    'DAFTAR',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.blue, // foreground
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: Text('Sudah Punya Akun? Masuk'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> Submit(BuildContext context) async {
    try {
      Dialogs.showLoadingDialog(context, GlobalKey());
      Signup();
    } catch (error) {
      print(error);
    }
  }
}
