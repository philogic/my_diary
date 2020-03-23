import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return !snapshot.hasData 
            ? Center(child: CircularProgressIndicator())
            : Center(child: Text('My Diary'));
        },
      ),
    );
  }
}