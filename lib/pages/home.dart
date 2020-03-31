import 'package:flutter/material.dart';
import 'package:my_diary/pages/edit_entry.dart';
import 'package:my_diary/classes/database.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Database _database;

  Future<List<Content>> _loadContents() async {
    await DatabaseFileRoutines().readContents().then((contentsJson) {
      _database = databaseFromJson(contentsJson);
      _database.content.sort((comt1, comt2) => comt2.date.compareTo(comt1.date));
    });
    return _database.content;
  }

  void _addOrEditContent({bool add, int index, Content content}) async {
    ContentEdit _contentEdit = ContentEdit(action: '', content: content);
    _contentEdit = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => EditEntry(
          add: add,
          index: index,
          contentEdit: _contentEdit,
        ),
        fullscreenDialog: true
      )
    );
    switch (_contentEdit.action) {
      case 'Save':
        if (add) {
          setState(() {
            _database.content.add(_contentEdit.content);
          });
        } else {
          setState(() {
            _database.content[index] = _contentEdit.content;
          });
        }
        DatabaseFileRoutines().writeContents(databaseToJson(_database));
        break;
      case 'Cancel':
        break;
      default:
        break;
    }
  }

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