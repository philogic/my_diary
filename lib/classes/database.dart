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

  Future<String> readEntries() async {

    try {
      
      final file = await _localFile;

      if (!file.existsSync()) {
        print('File does not exist: ${file.absolute}');
        await writeEntries('{"Entries": []}');
      }
      String contents = await file.readAsString();
      return contents;

    } catch (e) {
      print('Error readEntries $e');
      return '';
    }
  }

  Future<File> writeEntries (String json) async {
    final file = await _localFile;
    return file.writeAsString('$json');
  }
}
