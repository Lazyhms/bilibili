import 'package:bilibili/bangumi/content.dart';
import 'package:flutter/material.dart';

class Bangumi extends StatefulWidget {
  const Bangumi({Key? key}) : super(key: key);

  @override
  _BangumiState createState() => _BangumiState();
}

class _BangumiState extends State<Bangumi> {
  final List<String> tabs = [
    '推荐',
    '高分番剧',
    '官方延伸',
  ];
  final List<Widget> tabViews = [
    const BangumiContent(8),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0, //默认选中
      child: Scaffold(
        appBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.pinkAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.pinkAccent,
          isScrollable: true,
          tabs: tabs.map((String title) {
            return SizedBox(
              width: 70,
              height: 50,
              child: Tab(
                text: title,
              ),
            );
          }).toList(),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}
