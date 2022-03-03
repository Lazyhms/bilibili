part of apiconstants;

class _Home {
  static const instance = _Home._();

  factory _Home() => instance;

  const _Home._();

  /// 推荐视频.
  final String recommend = "${ApiConstants.appBase}/x/v2/feed/index";

  /// 热门 - gRPC.
  final String popularGRPC =
      "${ApiConstants.apiBase}/bilibili.app.show.v1.Popular/Index";

  /// 排行榜 - Web.
  final String ranking = "${ApiConstants.apiBase}/x/web-interface/ranking/v2";

  /// 排行榜 - gRPC.
  final String rankingGRPC =
      "${ApiConstants.grpcBase}/bilibili.app.show.v1.Rank/RankRegion";
}
