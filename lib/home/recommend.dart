import 'package:bilibili/home/card.dart';
import 'package:bilibili/model/recommend.dart';
import 'package:bilibili/service/api.dart' show RecommendService;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Recommend extends StatefulWidget {
  const Recommend({Key? key}) : super(key: key);

  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend>
    with AutomaticKeepAliveClientMixin<Recommend> {
  final List<RecommendCard> recommend = [];
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.grey[200],
      child: builderSmartRefresher(),
    );
  }

  Widget builderSmartRefresher() {
    return SmartRefresher(
      enablePullUp: true,
      controller: _refreshController,
      onLoading: () async {
        var offset = recommend.isNotEmpty ? recommend.last.index : 0;
        await _loadingData(0, offset);
      },
      onRefresh: () async {
        await _loadingData(1, 0);
      },
      footer: CustomFooter(
        builder: (context, LoadStatus? mode) {
          return SizedBox(
            height: 30,
            child: LoadStatus.loading == mode
                ? const CupertinoActivityIndicator()
                : (LoadStatus.failed == mode
                    ? const Center(
                        child: Text("data"),
                      )
                    : const Center(child: Text("正在加载"))),
          );
        },
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//控制主轴/纵轴之间空隙，列数，宽高比
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 2.0,
                crossAxisCount: 2,
                childAspectRatio: 0.9),
            padding: const EdgeInsets.all(5),
            itemCount: recommend.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: CardItemView(cardItem: recommend[index]),
                onTap: () {},
                onLongPress: () {
                  openUrl(recommend[index].cover);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadingData(int type, int offset) async {
    try {
      await RecommendService.getRecommendCardsAsync(offset, (data) {
        setState(() {
          var tempRecommend = <RecommendCard>[];
          for (var element in data["data"]["items"]) {
            tempRecommend.add(RecommendCard.fromJson(element));
          }
          if (type == 0) {
            // 加载
            recommend.addAll(tempRecommend);
            _refreshController.loadComplete();
          } else if (type == 1) {
            // 刷新
            recommend.insertAll(0, tempRecommend);
            _refreshController.refreshCompleted();
          }
        });
      });
      if (mounted) {}
    } catch (_) {
      type == 0
          ? _refreshController.loadComplete()
          : _refreshController.refreshCompleted();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

openUrl(String url) async {}
