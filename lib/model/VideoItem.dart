class VideoItem {
  VideoItem(
      {this.danmu,
      this.cover,
      this.msg,
      this.title,
      this.time,
      this.view,
      this.id,
      this.aid,
      this.tname,
      this.desc});

  String? title;
  String? time;
  String? view;
  String? danmu;
  String? msg;
  String? cover;
  String? id;
  String? aid;
  String? tname;
  String? desc;
  String? author;

  VideoItem.fromSearchJson(Map<String, dynamic> jsondata) {}
}
