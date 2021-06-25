import 'package:apni_kaksha/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apni Kaksha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomeScreen() 
    );
  }
}

