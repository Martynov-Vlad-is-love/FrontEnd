import 'package:flutter/material.dart';
import 'package:diving/Pages/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ProDiving',

        // color: Colors.red[300];
        home: LoginScreen());
  }
}
