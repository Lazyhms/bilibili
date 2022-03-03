import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MemoryStorage {
  Future<SharedPreferences> getInstance() => SharedPreferences.getInstance();

  Future<bool> setMapList(String key, List<Map> value) async {
    return setList(key, value);
  }

  Future<List<Map>> getMapList(String key) async {
    return getList<Map>(key);
  }

  Future<bool> setList<T>(String key, List<T> value) async {
    var storage = await getInstance();
    return storage.setString(key, jsonEncode(value));
  }

  Future<List<T>> getList<T>(String key) async {
    var storage = await getInstance();
    var getValue = storage.getString(key);
    return (getValue == null || getValue.isEmpty)
        ? <T>[]
        : (jsonDecode(getValue) as List<T>);
  }
}
