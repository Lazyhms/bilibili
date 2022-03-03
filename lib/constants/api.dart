library apiconstants;

part 'api.home.dart';

part 'api.pgc.dart';

class ApiConstants {
  static const String apiBase = "https://api.bilibili.com";
  static const String appBase = "https://app.bilibili.com";
  static const String vcBase = "https://api.vc.bilibili.com";
  static const String liveBase = "https://api.live.bilibili.com";
  static const String passBase = "https://passport.bilibili.com";
  static const String bangumiBase = "https://bangumi.bilibili.com";
  static const String grpcBase = "https://grpc.biliapi.net";

  static const _Home home = _Home.instance;
  static const _Pgc pgc = _Pgc.instance;
}
