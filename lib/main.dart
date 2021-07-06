import 'package:flutter/material.dart';
// import 'package:mini_project/Screen/Login_Screen.dart';
import 'package:mini_project/Screen/Splash_Screen.dart';
// import 'package:mini_project/Screen/Splash_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartUp(),
    );
  }
}
