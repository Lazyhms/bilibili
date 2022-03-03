/// 专业产出内容响应结果（包括动漫，电影，电视剧，纪录片等非用户产出内容）.
class PgcResponse {
  /// 数据源标识.
  late PgcFeedIdentifier feedIdentifier = PgcFeedIdentifier();

  /// 模块.
  late List<PgcModule> modules = [];

  /// 下次请求的指针.
  late String nextCursor = '';

  PgcResponse();

  PgcResponse.fromJson(Map<String, dynamic> json) {
    nextCursor = json['json'] ?? '';
    if (json['feed'] != null) {
      feedIdentifier = PgcFeedIdentifier.fromJson(json['feed'] ?? {});
    }
    if (json['modules'] != null) {
      for (var element in json['modules']) {
        modules.add(PgcModule.fromJson(element));
      }
    }
  }
}

/// <summary>
/// PGC数据源标识.
/// </summary>
class PgcFeedIdentifier {
  /// 下属分区Id.
  late List<int> partitionIds = [];

  /// 数据源类型.
  late String type = '';

  PgcFeedIdentifier();

  PgcFeedIdentifier.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    if (json['fall_wid'] != null) {
      for (var element in json['fall_wid']) {
        partitionIds.add(element);
      }
    }
  }
}

/// 动漫及影视模块.
class PgcModule {
  /// 模块子项列表.
  late List<PgcModuleItem> items = [];

  /// 模块Id.
  late int id = 0;

  /// <smm
  /// 模块样式. banner, function, v_card, topic.
  late String style = '';

  /// 模块标题.
  late String title = '';

  /// 模块类型.
  late int type = 0;

  /// 模块头列表.
  late List<PgcModuleHeader> headers = [];

  PgcModule.fromJson(Map<String, dynamic> json) {
    id = json['module_id'] ?? 0;
    style = json['style'] ?? '';
    title = json['title'] ?? '';
    type = json['type'] ?? 0;
    if (json['items'] != null) {
      for (var element in json['items']) {
        items.add(PgcModuleItem.fromJson(element));
      }
    }
    if (json['headers'] != null) {
      for (var element in json['headers']) {
        headers.add(PgcModuleHeader.fromJson(element));
      }
    }
  }
}

/// PGC内容头.
class PgcModuleHeader {
  /// 标题.
  late String title = '';

  /// 导航地址.
  late String url = '';

  PgcModuleHeader.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    url = json['url'] ?? '';
  }
}

/// 动漫及影视模块条目.
class PgcModuleItem {
  /// 分集Id.
  late int aid = 0;

  /// 徽章内容.
  late String badge = '';

  /// 网页链接.
  late String webLink = '';

  /// 分集cid.
  late int cid = 0;

  /// 封面.
  late String cover = '';

  /// 描述内容.
  late String description = '';

  /// 最新章节.
  late PgcEpisode newEpisode = PgcEpisode();

  /// 所属动漫或影视剧的Id.
  late int originId = 0;

  /// 剧集的季Id.
  late int seasonId = 0;

  /// 剧集的标签.
  late String seasonTags = '';

  /// PGC用户交互参数.
  late PgcItemStat stat = PgcItemStat();

  /// 标题.
  late String title = '';

  /// 卡片类型.
  late String type = '';

  /// 动漫状态.
  late PgcItemStatus status = PgcItemStatus();

  /// 徽章内容.
  late List<PgcModuleItem> cards = [];

  /// 显示的综合评分文本.
  late String displayScoreText = '';

  PgcModuleItem.fromJson(Map<String, dynamic> json) {
    aid = json['aid'] ?? 0;
    badge = json['badge'] ?? '';
    webLink = json['blink'] ?? '';
    cid = json['cid'] ?? 0;
    cover = json['cover'] ?? '';
    description = json['desc'] ?? '';
    newEpisode = PgcEpisode.fromJson(json['new_ep'] ?? {});
    originId = json['oid'] ?? 0;
    seasonId = json['season_id'] ?? 0;
    seasonTags = json['season_styles'] ?? '';
    stat = PgcItemStat.fromJson(json['stat'] ?? {});
    title = json['title'] ?? '';
    type = json['type'] ?? '';
    status = PgcItemStatus.fromJson(json['status'] ?? {});
    displayScoreText = json['pts'] ?? '';
    if (json['cards'] != null) {
      for (var element in json['cards']) {
        cards.add(PgcModuleItem.fromJson(element));
      }
    }
  }
}

/// 剧集信息.
class PgcEpisode {
  /// 剧集封面.
  late String cover = '';

  /// 剧集Id.
  late int id = 0;

  /// 显示内容.
  late String displayText = '';

  PgcEpisode();

  PgcEpisode.fromJson(Map<String, dynamic> json) {
    cover = json['cover'] ?? '';
    id = json['id'] ?? 0;
    displayText = json['index_show'] ?? '';
  }
}

/// 内容参数.
class PgcItemStat {
  /// 弹幕数.
  late int danmakuCount = 0;

  /// 关注数.
  late int followCount = 0;

  /// 关注的显示文本.
  late String followDisplayText = '';

  /// 观看次数.
  late int viewCount = 0;

  PgcItemStat();

  PgcItemStat.fromJson(Map<String, dynamic> json) {
    danmakuCount = json['danmaku'] ?? 0;
    followCount = json['follow'] ?? 0;
    followDisplayText = json['follow_view'] ?? '';
    viewCount = json['view'] ?? 0;
  }
}

/// 内容状态（关于我是否关注或点赞）.
class PgcItemStatus {
  /// 是否已关注，0-未关注，1-已关注.
  late int isFollow = 0;

  /// 是否已点赞，0-未点赞，1-已点赞.
  late int isLike = 0;

  PgcItemStatus();

  PgcItemStatus.fromJson(Map<String, dynamic> json) {
    isFollow = json['follow'] ?? 0;
    isLike = json['like'] ?? 0;
  }
}
