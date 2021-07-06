// import 'package:flutter/material.dart';
// import 'package:mini_project/Screen/Login_Screen.dart';
// import 'package:splashscreen/splashscreen.dart';

// class StartUp extends StatefulWidget {
//   StartUp({Key? key}) : super(key: key);
//   @override
//   _StartUpState createState() => _StartUpState();
// }

// class _StartUpState extends State<StartUp> {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//       seconds: 14,
//       navigateAfterSeconds: new AfterSplash(),
//       title: new Text(
//         'Welcome In SplashScreen',
//         style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//       ),
//       image: new Image.network(
//           'https://flutter.io/images/catalog-widget-placeholder.png'),
//       backgroundColor: Colors.white,
//       loaderColor: Colors.red,
//     );
//   }
// }

// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text("Welcome In SplashScreen Package"),
//         automaticallyImplyLeading: false,
//       ),
//       body: new Center(
//         child: new Text(
//           "Succeeded!",
//           style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
//         ),
//       ),
//     );
//   }
// }
