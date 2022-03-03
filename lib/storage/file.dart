import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileStorage {
  Future<String> get _localPath async {
    final directory = Directory("/sdcard/Download/");
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    return directory.path;
  }

  Future<bool> writeToDisk(Object? content, String fileName) async {
    var localPath = await _localPath;
    var file = File('$localPath/$fileName');
    if (file.existsSync()) {
      await file.delete(recursive: true);
    }
    file.createSync(recursive: true);
    file.writeAsStringSync(jsonEncode(content), flush: true);

    return true;
  }

  Future<String> readFromFile(String path) async {
    var file = File(path);
    if (file.existsSync()) {
      return await file.readAsString();
    }
    return "";
  }

  Future<String> get openFileFromDisk async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result != null) {
      return result.paths.first ?? "";
    }
    return "";
  }

  Future<List<String?>> get openMultipleFileFromDisk async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      return result.paths;
    }
    return [];
  }
}
