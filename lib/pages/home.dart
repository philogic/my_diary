import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void pressAddButton() {
    print('Button Pressed!');
  }
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(padding: EdgeInsets.all(24.0)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add to Diary',
        child: Icon(Icons.add),
        onPressed: pressAddButton,
      ),
    );
  }
}