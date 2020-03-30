import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_diary/classes/database.dart';


class EditEntry extends StatefulWidget {
  final bool add;
  final int index;
  final ContentEdit contentEdit;

  const EditEntry({Key key, this.add, this.index, this.contentEdit}) : super(key: key);
  @override
  _EditEntryState createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {

  ContentEdit _contentEdit;
  String _title;
  DateTime _selectedDateAndTime;
  TextEditingController _moodController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  FocusNode _moodFocus = FocusNode();
  FocusNode _noteFocus = FocusNode();

  @override
  void initState() { 
    super.initState();
    _contentEdit = ContentEdit(action: 'Cancel', content: widget.contentEdit.content);
    _title = widget.add ? 'Add' : 'Edit';
    _contentEdit.content = widget.contentEdit.content;

    if (widget.add) {
      _selectedDateAndTime = DateTime.now();
      _moodController.text = '';
      _noteController.text = '';
    } else {
      _selectedDateAndTime = DateTime.parse(_contentEdit.content.date);
      _moodController.text = _contentEdit.content.mood;
      _noteController.text = _contentEdit.content.note;
    }
  }

  @override
  void dispose() {
    _moodController.dispose();
    _noteController.dispose();
    _moodFocus.dispose();
    _noteFocus.dispose();
    super.dispose();
  }

  Future<DateTime> _selectDateAndTime(DateTime selectedDateAndTime) async {
    DateTime _initialDateAndTime = selectedDateAndTime;
    final DateTime _pickedDateAndTime = await showDatePicker(
      context: context,
      initialDate: _initialDateAndTime,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365))
    );

    if (_pickedDateAndTime != null) {
      selectedDateAndTime = DateTime(
        _pickedDateAndTime.year,
        _pickedDateAndTime.month,
        _pickedDateAndTime.day,
        _initialDateAndTime.hour,
        _initialDateAndTime.minute,
        _initialDateAndTime.second,
        _initialDateAndTime.millisecond,
        _initialDateAndTime.microsecond
      );
    }

    return selectedDateAndTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title Entry'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(0.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 22.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 16.0),
                    Text(
                      DateFormat.yMMMEd().format(_selectedDateAndTime),
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime _pickerDateAndTime = await _selectDateAndTime(_selectedDateAndTime);
                  setState(() {
                    _selectedDateAndTime = _pickerDateAndTime;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
