import 'dart:convert';

class PgcTab {
  late int id = 0;
  late String link = '';
  late String title = '';

  PgcTab();

  PgcTab.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? id;
    link = json['link'] ?? '';
    title = json['title'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'title': title,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
