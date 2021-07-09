import 'dart:async';
import 'dart:io';
// import 'dart:js';
import 'dart:typed_data';

// import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Common/color.dart';
import 'package:mini_project/Common/dialog.dart';
import 'package:mini_project/Common/snacbar.dart';
import 'package:mini_project/Service/Ftp_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard._Screen.dart';
// import 'dart:io';
// import 'package:ftpconnect/ftpConnect.dart';

class PreviewScreen extends StatefulWidget {
  final String imgPath;
  final String fileName;
  PreviewScreen({this.imgPath, this.fileName});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

Future<void> upload(File fileName) async {
  print(fileName);
  print("proses");
}

class _PreviewScreenState extends State<PreviewScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final TextEditingController latitude = new TextEditingController();
  final TextEditingController longitude = new TextEditingController();
  final TextEditingController alamat = new TextEditingController();
  final TextEditingController deskrispi = new TextEditingController();
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final date = DateTime.now().millisecondsSinceEpoch.toString();
    print(prefs.getString('useraddress'));
    alamat.text = prefs.getString('useraddress');
    latitude.text = prefs.getString('userlatitude');
    longitude.text = prefs.getString('userlongitude');
  }

  Future<void> Simpan(File file) async {
    String deskripsi = deskrispi.text;
    final FtpService ftpService = new FtpService();
    bool isSuccess = await ftpService.uploadFile(file, deskripsi);
    if (isSuccess) {
      print(isSuccess);
      showSnakbar(context, "Berhasil", SuccesColor);
      Navigator.of(context, rootNavigator: true).pop();
      var _duration = new Duration(seconds: 1);
      new Timer(_duration, () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new PageDashboard()));
      });
    } else {
      showSnakbar(context, "Gagal", ErrorColor);
      Navigator.of(context, rootNavigator: true).pop();
      print(isSuccess);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("hayo loh");
    print(widget.imgPath + widget.fileName);
    getdata();
    return Scaffold(
      // backgroundColor: Colors.wh,
      appBar: AppBar(title: const Text('Display the Picture')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Container(
                  width: 300,
                  height: 400,
                  child: Image.file(File(widget.imgPath)),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  // decoration: InputDecoration(border: ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // controller: controlleremail,
                // cursorHeight: 10.0,
                controller: alamat,
                autofocus: true,
                keyboardType: TextInputType.text,
                maxLines: 5,
                minLines: 1,
                // controller: alamat,
                readOnly: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Alamat',
                    focusColor: Colors.black,
                    hintText: 'Masukan Deskripsi'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                readOnly: true,
                // controller: controlleremail,
                // cursorHeight: 10.0,
                controller: latitude,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Latitude',
                    focusColor: Colors.black,
                    hintText: 'Masukan Deskripsi'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // controller: controlleremail,
                // cursorHeight: 10.0,
                readOnly: true,
                controller: longitude,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Longitude',
                    focusColor: Colors.black,
                    hintText: 'Masukan Deskripsi'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // controller: controlleremail,
                // cursorHeight: 10.0,
                maxLines: 5,
                minLines: 1,
                controller: deskrispi,
                autofocus: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(5.0))),
                    labelText: 'Deskripsi',
                    focusColor: Colors.black,
                    hintText: 'Masukan Deskripsi'),
              ),
            ),
            Container(
              // padding: EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20.0),
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                onPressed: () async {
                  Submit(context, File(widget.imgPath));
                  // Simpan(File(widget.imgPath));
                  // alamat.text = "aaa";
                  // Simpan();
                  // final FtpService ftpService = new FtpService();
                  // final date = DateTime.now().millisecondsSinceEpoch.toString();
                  // final SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // final timestamp = date.substring(0, 10);
                  // ftpService.uploadFile(File(imagePath),
                  //     preferences.getString('guid_id'), timestamp);
                  // Simpan(File(imagePath));

                  // Submit(context);
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Text(
                  'SIMPAN',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            )
          ],
        ),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      // body: Image.file(File(imagePath)),
    );
    // return Scaffold(
    //     appBar: AppBar(
    //       automaticallyImplyLeading: true,
    //     ),
    //     body: Container(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: <Widget>[
    //           Expanded(
    //             flex: 2,
    //             child: Image.file(
    //               File(widget.imgPath),
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           Align(
    //             alignment: Alignment.bottomCenter,
    //             child: Container(
    //               width: double.infinity,
    //               height: 60,
    //               color: Colors.black,
    //               child: Center(
    //                 child: IconButton(
    //                   icon: Icon(
    //                     Icons.share,
    //                     color: Colors.white,
    //                   ),
    //                   onPressed: () {
    //                     print("di klik");
    //                     upload(File(widget.imgPath));
    //                     // getBytes().then((bytes) {
    //                     //   print('here now');
    //                     //   print(widget.imgPath);
    //                     //   print(bytes.buffer.asUint8List());
    //                     //   Share.file('Share via', widget.fileName,
    //                     //       bytes.buffer.asUint8List(), 'image/path');
    //                     // });
    //                   },
    //                 ),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ));
  }

  Future getBytes() async {
    Uint8List bytes = File(widget.imgPath).readAsBytesSync() as Uint8List;
//    print(ByteData.view(buffer))
    return ByteData.view(bytes.buffer);
  }

  Future<void> Submit(BuildContext context, File file) async {
    try {
      Dialogs.showLoadingDialog(context, _keyLoader);
      Simpan(file);
    } catch (error) {
      print(error);
    }
  }
}

// Future<void> Succses() async {
//   showSnakbar(BuildContext context,"Berhasil Membuat Report", SuccesColor);
// }
