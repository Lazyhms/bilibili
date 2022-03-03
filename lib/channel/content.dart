import 'package:bilibili/model/jsonmodel/ChannelItem.dart';
import 'package:bilibili/util/GetUtilBilibili.dart';
import 'package:flutter/material.dart';

class ChannelContent extends StatefulWidget {
  const ChannelContent({Key? key}) : super(key: key);

  @override
  _ChannelContentState createState() => _ChannelContentState();
}

class _ChannelContentState extends State<ChannelContent> {
  List<ChannelItem> channellist = <ChannelItem>[];

  @override
  void initState() {
    super.initState();
    getChannelList();
  }

  getChannelList() async {
    channellist.addAll(await GetUtilBilibili.getChannelList());
    setState(() {});
  }

  Future<void> _onrefresh() async {
    channellist.clear();
    channellist.addAll(await GetUtilBilibili.getChannelList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return buildChannelGridView();
  }

  Widget buildChannelGridView() {
    return RefreshIndicator(
      onRefresh: _onrefresh,
      child: GridView.builder(
        itemCount: channellist.length,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, i) {
          return ChannelCard(channellist[i]);
        },
      ),
    );
  }
}

class ChannelCard extends StatelessWidget {
  late final ChannelItem item;

  ChannelCard(
    ChannelItem i, {
    Key? key,
  }) : super(key: key) {
    item = i;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            //图标
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(item.logo!))),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            item.name!,
            style: const TextStyle(letterSpacing: 3, fontSize: 12),
          )
          //文字
        ],
      ),
    );
  }
}
