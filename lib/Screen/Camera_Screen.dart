import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// import 'package:ftpclient/ftpclient.dart';
import 'package:mini_project/Service/Ftp_Service.dart';
import 'package:shared_preferences/shared_preferences.dart';
//  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
// final firstCamera = cameras.first;

Future<void> mainCamera() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Pass the appropriate camera to the TakePictureScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}
// class Camera extends StatelessWidget {
//   // const Camera({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TakePictureScreen(camera: firstCamera),
//     );
//   }
// }

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const TakePictureScreen({
    Key key,
    this.camera,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

mixin required {}

IconData getCameraLensIcon(CameraLensDirection direction) {
  switch (direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
    default:
      throw ArgumentError('Unknown lens direction');
  }
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController alamat = new TextEditingController();
  TextEditingController latitude = new TextEditingController();
  TextEditingController longitude = new TextEditingController();
  TextEditingController deskrispi = new TextEditingController();
  void showSnakbar(BuildContext context, Message, color) {
    final snackBar = SnackBar(content: Text(Message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            // If the picture was taken, display it on a new screen.
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  // Pass the automatically generated path to
                  // the DisplayPictureScreen widget.
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  child: Image.file(File(imagePath)),
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
                // controller: controlleremail,
                // cursorHeight: 10.0,
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
                  final FtpService ftpService = new FtpService();
                  final date = DateTime.now().millisecondsSinceEpoch.toString();
                  final SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  final timestamp = date.substring(0, 10);
                  ftpService.uploadFile(File(imagePath),
                      preferences.getString('guid_id'), timestamp);
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
  }

  Simpan(File file) {
    // print(file);
    // FTPClient ftpClient = FTPClient('pasar.pptik.id',
    //     user: 'pasar', pass: 'b4lanj!d!pas4Rb4lanj!d!pas4R', port: 2121);

    // ftpClient.connect();
    // ftpClient.uploadFile(File(imagePath), sRemoteName: 'pptik.jpg  ');
    // ftpClient.disconnect();

    // Connect to FTP Server
    // ftpClient.connect();

    // try {
    //   // Upload File
    //   ftpClient.uploadFile(file);
    // } finally {
    //   // Disconnect
    //   ftpClient.disconnect();
    // }
  }
}
