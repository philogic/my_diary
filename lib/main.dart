import 'package:flutter/material.dart';
import 'package:my_diary/pages/home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomAppBarColor: Colors.blue
      ),
      home: Home(),
    );
  }
}