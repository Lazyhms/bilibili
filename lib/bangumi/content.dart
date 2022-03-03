import 'package:bilibili/model/pgcmodule.dart';
import 'package:bilibili/service/api.dart' show PgcService;
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'card.dart';

class BangumiContent extends StatefulWidget {
  const BangumiContent(
    this.tabId, {
    Key? key,
  }) : super(key: key);

  final int tabId;

  @override
  _BangumiContentState createState() => _BangumiContentState();
}

class _BangumiContentState extends State<BangumiContent> {
  late PgcResponse _pgcResponse = PgcResponse();
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadingData() async {
    try {
      await PgcService.getPgcTabDetailAsync(widget.tabId, (data) {
        if (mounted) {
          setState(() {
            _pgcResponse = PgcResponse.fromJson(data['result']);
            _refreshController.refreshCompleted();
          });
        }
      });
    } catch (_) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () async {
        await _loadingData();
      },
      child: ListView(
        children: [
          buildBanners(),
          buildRanking(),
        ],
      ),
    );
  }

  buildBanners() {
    if (_pgcResponse.modules.isEmpty) {
      return const Text("");
    }
    var banner = _pgcResponse.modules
        .where((element) => element.style.contains('banner'))
        .first
        .items;
    return Container(
      margin: const EdgeInsets.all(10),
      height: 193,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Swiper(
          itemCount: banner.length,
          autoplay: true,
          pagination: SwiperPagination(
              alignment: Alignment.bottomRight,
              builder: DotSwiperPaginationBuilder(
                color: Colors.white,
                activeColor: Theme.of(context).primaryColor,
              )),
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    banner[index].cover,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromRGBO(0, 0, 0, 0.01), Colors.black54]),
                ),
                child: Text(
                  banner[index].title,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  buildRanking() {
    if (_pgcResponse.modules.isEmpty) {
      return const Text("");
    }
    var rank = _pgcResponse.modules
        .where((element) => element.style.contains('rank'))
        .first
        .items;
    return Container(
      margin: const EdgeInsets.all(8),
      height: 650,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rank.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 400,
            child: Card(
              elevation: 0.5,
              color: Colors.grey[100],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children:
                    builderRankItems(rank[index].title, rank[index].cards),
              ),
            ),
          );
        },
      ),
    );
  }

  builderRankItems(String title, List<PgcModuleItem> items) {
    var expanded = <Widget>[
      Expanded(
        child: ListTile(
          title: Text(title),
        ),
      )
    ];
    expanded.addAll(items.map(
      (element) => Expanded(
        child: CardItemView(_pgcResponse.nextCursor, element),
      ),
    ));
    return expanded;
  }
}
