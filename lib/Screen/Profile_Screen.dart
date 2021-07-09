import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String namaLengkap = "", alamat = "", noTelp = "";
  final _globalKey = GlobalKey<ScaffoldState>();

  TextEditingController emailController = new TextEditingController();
  TextEditingController namaLengkapController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();
  TextEditingController noTelpController = new TextEditingController();

  TextEditingController passwordOldController = new TextEditingController();
  TextEditingController passwordNewController = new TextEditingController();
  TextEditingController passwordRepeatController = new TextEditingController();

  void getProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      namaLengkap = sharedPreferences.getString('nama');
      // alamat = sharedPreferences.getString('alamat');
      noTelp = sharedPreferences.getInt('telp').toString();
      emailController.text = sharedPreferences.getString('email');
      namaLengkapController.text = namaLengkap;
      alamatController.text = alamat;
      noTelpController.text = noTelp;
    });
  }

  void updateProfile() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var url = masterurl + 'updateprofile/' + sharedPreferences.getString('id');

    // final response = await http.post(url, body: {
    //   "email": emailController.text,
    //   "namaLengkap": namaLengkapController.text,
    //   "alamat": alamatController.text,
    //   "noTelp": noTelpController.text,
    // });

    // Navigator.pop(context);

    // var result = json.decode(response.body);
    // if (result['sukses']) {
    //   sharedPreferences.setString("email", emailController.text);
    //   sharedPreferences.setString("namaLengkap", namaLengkapController.text);
    //   sharedPreferences.setString("alamat", alamatController.text);
    //   sharedPreferences.setString("noTelp", noTelpController.text);
    //   this.getProfile();
    //   showSnackbar(context, result['msg'], suksesColor);
    // } else {
    //   showSnackbar(context, result['msg'], dangerColor);
    // }
  }

  final _updateProfileKey = GlobalKey<FormState>();
  _displayUpdateProfile(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ListView(
            children: <Widget>[
              Form(
                key: _updateProfileKey,
                child: AlertDialog(
                  elevation: 0.0,
                  title: Text('Ubah Profile'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi E-Mail";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "E-Mail", labelText: "E-Mail"),
                      ),
                      TextFormField(
                        controller: namaLengkapController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi Nama Lengkap";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Nama Lengkap",
                            labelText: "Nama Lengkap"),
                      ),
                      TextFormField(
                        controller: alamatController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi Alamat";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Alamat", labelText: "Alamat"),
                      ),
                      TextFormField(
                        controller: noTelpController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi No Telp";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "No Telp", labelText: "No Telp"),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text('Update Data'),
                      onPressed: () {
                        if (_updateProfileKey.currentState.validate()) {
                          updateProfile();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  final _changePasswordKey = GlobalKey<FormState>();
  _displayChangePassword(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            children: <Widget>[
              Form(
                key: _changePasswordKey,
                child: AlertDialog(
                  elevation: 0.0,
                  title: Text('Ganti password'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi Password Baru";
                          }
                          return null;
                        },
                        controller: passwordOldController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password Lama Anda",
                            labelText: "Password Lama Anda"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mohon Isi Password Lama";
                          }
                          return null;
                        },
                        controller: passwordNewController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password Baru",
                            labelText: "Password Baru"),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Ketik Ulang Password Dengan Benar";
                          } else if (value != passwordNewController.text) {
                            return 'Ketik Ulang Password Dengan Benar';
                          }
                          return null;
                        },
                        controller: passwordRepeatController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Ketik Ulang Password Baru",
                            labelText: "Ketik Ulang Password Baru"),
                      )
                    ],
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    new FlatButton(
                      child: new Text('Update Data'),
                      onPressed: () {
                        if (_changePasswordKey.currentState.validate()) {
                          changePassword();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  void changePassword() async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var url = masterurl + 'changepassword/' + sharedPreferences.getString('id');

    // final response = await http.post(url, body: {
    //   "oldPassword": passwordOldController.text,
    //   "newPassword": passwordNewController.text,
    // });

    // setState(() {
    //   passwordNewController.text = '';
    //   passwordOldController.text = '';
    //   passwordRepeatController.text = '';
    // });

    // Navigator.pop(context);

    // var result = json.decode(response.body);
    // if (result['sukses']) {
    //   showSnackbar(context, result['msg'], suksesColor);
    // } else {
    //   showSnackbar(context, result['msg'], dangerColor);
    // }
  }

  void showSnackbar(BuildContext context, msg, color) {
    final snackBar = SnackBar(content: Text(msg), backgroundColor: color);
    _globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _globalKey,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Profile', style: TextStyle(color: Colors.blue))),
      backgroundColor: Colors.amber,
      body: Container(
//        color: fourth,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15.0, bottom: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 40,
                          child: Icon(
                            Icons.perm_identity,
                            size: 50.0,
                            color: Colors.amber,
                          )),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            namaLengkap,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.pin_drop),
                              Text(
                                alamat,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.call),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                noTelp,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: ButtonTheme(
                          minWidth: 170.0,
                          height: 45.0,
                          child: GestureDetector(
                            onTap: () {
                              _displayUpdateProfile(context);
                            },
                            child: Container(
                              width: 170.0,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: Text(
                                'Ubah Profil',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                          ))),
                  Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: ButtonTheme(
                          minWidth: 170.0,
                          height: 45.0,
                          child: GestureDetector(
                            onTap: () {
                              _displayChangePassword(context);
                            },
                            child: Container(
                              width: 170.0,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: Text(
                                'Ganti Password',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.0),
                              ),
                            ),
                          )))
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: ButtonTheme(
                    minWidth: 400.0,
                    height: 45.0,
                    child: GestureDetector(
                      onTap: () {
                        // logout();
                        // Navigator.pushReplacement(
                        //     context,
                        //     new MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                        //             new Login()));
                      },
                      child: Container(
                        width: 200.0,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10.0)),
                        alignment: Alignment.center,
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ),
                    ))),
            Padding(padding: EdgeInsets.only(top: 20.0)),
          ],
        ),
      ),
    );
  }
}
