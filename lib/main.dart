import 'package:firebasedemo/screens/login.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
     
      theme: ThemeData(
       
        primarySwatch: Colors.brown,
      
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(title: 'Flutter Demo Home Page'),
     
    );
  }
}
