part of apiconstants;

class _Pgc {
  static const instance = _Pgc._();

  factory _Pgc() => instance;

  const _Pgc._();

  /// 顶部标签.
  final String tab = "${ApiConstants.apiBase}/pgc/page/tab";

  /// 页面详情.
  final String pageDetail = "${ApiConstants.apiBase}/pgc/page";

  /// 剧集详情.
  final String seasonDetail = "${ApiConstants.apiBase}/pgc/view/v2/app/season";

  /// 剧集播放信息.
  final String playInformation =
      "${ApiConstants.apiBase}/pgc/player/web/playurl";

  /// 分集交互信息.
  final String episodeInteraction =
      "${ApiConstants.apiBase}/pgc/season/episode/community";

  /// 追番/追剧.
  final String follow = "${ApiConstants.apiBase}/pgc/app/follow/add";

  /// 取消追番/追剧.
  final String unfollow = "${ApiConstants.apiBase}/pgc/app/follow/del";

  /// PGC索引条件.
  final String indexCondition =
      "${ApiConstants.apiBase}/pgc/season/index/condition";

  /// PGC索引筛选结果.
  final String indexResult = "${ApiConstants.apiBase}/pgc/season/index/result";

  /// 时间表.
  final String timeLine = "${ApiConstants.apiBase}/pgc/app/timeline";

  /// 播放列表.
  final String playList = "${ApiConstants.apiBase}/pgc/web/playlist";
}
