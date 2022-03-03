import 'dart:convert';
import 'dart:io';

import 'package:bilibili/model/jsonmodel/ChannelItem.dart';

class GetUtilBilibili {
  static const String appkey = "c1b107428d337928";

  static getChannelList() async {
    //获取频道列表//因为需要sign这个参数，暂时还不会计算，所以就直接用现成的数据
    try {
      List<ChannelItem> channellist = <ChannelItem>[];

      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://app.bilibili.com/x/channel/square" +
              "?appkey=1d8b6e7d45233436&build=5370000&channel=huawei&login_event=1&mobi_app=android&platform=android&ts=1557534415&sign=1f43ef46c4bf2d4d738ab7af0f809b3d"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      for (Map<String, dynamic> item in jsondata["data"]["region"]) {
        channellist.add(ChannelItem.fromJson(item));
      }
      httpClient.close();

      return channellist;
    } catch (e) {
      // print("search请求失败");
      return <ChannelItem>[];
    } finally {}
  }
}
