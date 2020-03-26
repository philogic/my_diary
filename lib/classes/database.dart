import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';


class DatabaseFileRoutines {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_data.json');
  }

  Future<String> readContents() async {

    try {
      
      final file = await _localFile;

      if (!file.existsSync()) {
        print('File does not exist: ${file.absolute}');
        await writeContents('{"Contents": []}');
      }
      String contents = await file.readAsString();
      return contents;

    } catch (e) {
      print('Error readContents $e');
      return '';
    }
  }

  Future<File> writeContents (String json) async {
    final file = await _localFile;
    return file.writeAsString('$json');
  }
}

Database databaseFromJson(String str) {
  final dataFromJson = json.decode(str);
  return Database.fromJson(dataFromJson);
}

String databaseToJson(Database data) {
  final dataToJson = data.toJson();
  return json.encode(dataToJson);
}



class Database {
  List<Content> content;

  Database({
    this.content
  });

  factory Database.fromJson(Map<String, dynamic> json) => Database(
    content: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contents": List<dynamic>.from(content.map((x) => x.toJson())),
  };
}

class Content {
  String id;
  String date;
  String mood;
  String note;

  Content({
    this.id,
    this.date,
    this.mood,
    this.note
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["id"],
    date: json["date"],
    mood: json["mood"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "mood": mood,
    "note": note
  };
}

class ContentEdit {
  String action;
  Content content;
  ContentEdit({this.action, this.content});
}
