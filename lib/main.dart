import 'package:flutter/material.dart';
import './widgets/homePage.dart';
import './widgets/session.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: MyHomePage()
      ),
    );
  }
}
