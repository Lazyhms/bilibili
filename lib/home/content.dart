import 'package:bilibili/home/recommend.dart';
import 'package:flutter/material.dart';

import '../bangumi/bangumi.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final List<String> tabs = [
    "直播",
    "推荐",
    "热门",
    "番剧",
    "影视",
  ];
  final List<Widget> tabViews = [
    Container(),
    const Recommend(),
    Container(),
    const Bangumi(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      initialIndex: 1, //默认选中
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
