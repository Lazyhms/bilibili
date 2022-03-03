/// 首页推荐
class RecommendCard {
  /// 卡片类型.
  late String cardType = '';

  /// 处理卡片的程序.
  late String cardGoto = '';

  /// 卡片参数.
  late RecommendCardArgs cardArgs = RecommendCardArgs();

  /// 偏移值标识符.
  late int index = 0;

  /// 上下文菜单项列表.
  late List<RecommendContextMenuItem> contextMenuItems = [];

  /// 需要播放的类型.
  late String goto = '';

  /// 封面.
  late String cover = '';

  /// 标题.
  late String title = '';

  /// 导航地址.
  late String navigateUri = '';

  /// 视频或番剧的Id.
  late String parameter = '';

  /// 播放参数.
  late PlayerArgs playerArgs = PlayerArgs();

  /// 播放数文本.
  late String playCountText = '';

  /// 状态副文本，对于视频来说是弹幕数，对于番剧来说是点赞数.
  late String subStatusText = '';

  /// 时长文本.
  late String durationText = '';

  /// 推荐原因.
  late String recommendReason = '';

  /// 是否可以播放，1-可以.
  late int canPlay = 1;

  /// 说明文本.
  late RecommendDescription description = RecommendDescription();

  RecommendCard.fromJson(Map json) {
    cardType = json['card_type'] ?? '';
    cardGoto = json['card_goto'] ?? '';
    cardArgs = RecommendCardArgs.fromJson(json['args'] ?? {});
    index = json['idx'] ?? 0;
    goto = json['goto'] ?? '';
    cover = json['cover'] ?? '';
    title = json['title'] ?? '';
    navigateUri = json['uri'] ?? '';
    parameter = json['param'] ?? '';
    playerArgs = PlayerArgs.fromJson(json['player_args'] ?? {});
    playCountText = json['cover_left_text_1'] ?? '';
    subStatusText = json['cover_left_text_2'] ?? '';
    durationText = json['cover_right_text'] ?? '';
    recommendReason = json['rcmd_reason'] ?? '';
    canPlay = json['can_play'] ?? 0;
    description = RecommendDescription.fromJson(json['desc_button'] ?? {});
    if (json['three_point_v2'] != null) {
      for (var element in json['three_point_v2']) {
        contextMenuItems.add(RecommendContextMenuItem.fromJson(element));
      }
    }
  }
}

/// 推荐卡片的参数.
class RecommendCardArgs {
  /// 发布者Id.
  late int publisherId = 0;

  /// 发布者名称.
  late String publisherName = '';

  /// 分区Id.
  late int partitionId = 0;

  /// 分区名称.
  late String partitionName = '';

  /// 子分区Id.
  late int subPartitionId = 0;

  /// 子分区名称.
  late String subPartitionName = '';

  /// 视频Aid.
  late int aid = 0;

  RecommendCardArgs();

  RecommendCardArgs.fromJson(Map<String, dynamic> json) {
    publisherId = json['up_id'] ?? '';
    publisherName = json['up_name'] ?? '';
    partitionId = json['rid'] ?? 0;
    partitionName = json['rname'] ?? '';
    subPartitionId = json['tid'] ?? 0;
    subPartitionName = json['tname'] ?? '';
    aid = json['aid'] ?? 0;
  }
}

/// 播放器参数.
class PlayerArgs {
  /// 视频的Aid.
  late int aid = 0;

  /// 视频第一个分P的Id.
  late int cid = 0;

  /// 视频类型，一般为av.
  late String type = '';

  /// 视频时长 (秒).
  late int duration = 0;

  PlayerArgs();

  PlayerArgs.fromJson(Map<String, dynamic> json) {
    aid = json['aid'] ?? 0;
    cid = json['cid'] ?? 0;
    type = json['type'] ?? '';
    duration = json['duration'] ?? 0;
  }
}

/// 推荐视频的上下文菜单内容.
class RecommendContextMenuItem {
  /// 显示标题.
  late String title = '';

  /// 菜单项类型。watch_later:稍后再看. feedback:反馈. dislike:不喜欢.
  late String type = '';

  /// 副标题.
  late String subtitle = '';

  /// 原因列表.
  late List<RecommendDislikeReason> reasons = [];

  RecommendContextMenuItem.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? '';
    type = json['type'] ?? '';
    subtitle = json['subtitle'] ?? '';
    if (json['reasons'] != null) {
      for (var element in json['reasons']) {
        reasons.add(RecommendDislikeReason.fromJson(element));
      }
    }
  }
}

/// 推荐视频的不喜欢原因.
class RecommendDislikeReason {
  /// 原因标识符.
  late int id = 0;

  /// 显示的文本.
  late String name = '';

  /// 提示文本.
  late String tip = '';

  RecommendDislikeReason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tip = json['toast'];
  }
}

/// 推荐辅助说明.
class RecommendDescription {
  /// 显示的说明文本.
  late String text = '';

  RecommendDescription();

  RecommendDescription.fromJson(Map<String, dynamic> json) {
    text = json["text"] ?? '';
  }
}
