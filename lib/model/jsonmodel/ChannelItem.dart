class ChannelItem {

  int? tid;
  String? name;
  String? logo;

  ChannelItem({this.logo, this.name, this.tid});

  ChannelItem.fromJson(Map<String, dynamic> map)
  {
    tid = map['tid'];
    name = map['name'];
    logo = map['logo'];
  }
}
