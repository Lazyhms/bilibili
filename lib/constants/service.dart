library serviceconstants;

part 'service.keys.dart';

part 'service.query.dart';

class ServiceConstants {
  static const String defaultAcceptString =
      "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9";
  static const String defaultUserAgentString =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36 Edg/92.0.902.62";
  static const String buildNumber = "5520400";
  static const String av = "av";
  static const String bangumi = "bangumi";
  static const String pgc = "pgc";
  static const String season = "season";
  static const String positive = "positive";
  static const String section = "section";

  /// 番剧分区Id.
  static const int bangumiPartitionId = 152;

  /// 国创分区Id.
  static const int domesticPartitionId = 167;

  static const String bangumiOperation = "bangumi-operation";
  static const String domesticOperation = "gc-operation";
  static const String movieOperation = "movie-operation";
  static const String tvOperation = "tv-operation";
  static const String documentaryOperation = "documentary-operation";

  static const _Keys keys = _Keys.instance;
  static const _Query query = _Query.instance;
}
