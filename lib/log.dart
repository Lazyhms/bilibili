library flutterlog;

import 'package:flutter/foundation.dart';

class LogLevel {
  final String name;

  const LogLevel._(String n) : name = n;

  static const LogLevel all = LogLevel._('all');

  static const LogLevel detail = LogLevel._('det');

  static const LogLevel verbose = LogLevel._('veb');

  static const LogLevel debug = LogLevel._('dbg');

  static const LogLevel info = LogLevel._('inf');

  static const LogLevel warn = LogLevel._('war');

  static const LogLevel error = LogLevel._('err');

  static const LogLevel fatal = LogLevel._('fal');

  static const LogLevel silent = LogLevel._('sil');

  @override
  String toString() {
    return 'LogLevel { name: $name }';
  }
}

class Log {
  static const String _project = "flutter";

  const Log._();

  static String? project;

  static log(LogLevel level, Object? msg) {
    if (kDebugMode) {
      final int id = DateTime.now().toLocal().millisecondsSinceEpoch;
      print(
          "====================================================");
      print("[${project ?? _project}] [${level.name}] [$id]");
      print(msg);
      print("[${project ?? _project}] [${level.name}] [$id]");
      print(
          "====================================================");
    }
  }

  static v(Object? msg) {
    log(LogLevel.verbose, msg);
  }

  static d(Object? msg) {
    log(LogLevel.debug, msg);
  }

  static i(Object? msg) {
    log(LogLevel.info, msg);
  }

  static w(Object? msg) {
    log(LogLevel.warn, msg);
  }

  static e(Object? msg) {
    log(LogLevel.error, msg);
  }
}
