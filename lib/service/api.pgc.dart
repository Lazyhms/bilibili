part of apiservice;

class PgcService {
  // 获取顶部导航（过滤掉网页标签）.
  static Future<void> getPgcTabsAsync(Function callback) async {
    var queryParameters = _Parameters._getQueryParameters(<String, Object>{
      ServiceConstants.query.device: "phone",
      ServiceConstants.query.isHideRecommendTab: 0,
      ServiceConstants.query.parentTab: ServiceConstants.bangumiOperation,
    });

    await Http().get(
      ApiConstants.pgc.tab,
      callback,
      queryParameters: queryParameters,
    );
  }

  static Future<void> getPgcTabDetailAsync(int tabId, Function callback) async {
    var queryParameters = _Parameters._getQueryParameters(<String, Object>{
      ServiceConstants.query.device: "phone",
      ServiceConstants.query.fnval: "976",
      ServiceConstants.query.fnver: "0",
      ServiceConstants.query.fourk: "1",
      ServiceConstants.query.qn: "112",
      ServiceConstants.query.tabId: tabId,
      ServiceConstants.query.teenagersMode: "0"
    });

    await Http().get(
      ApiConstants.pgc.pageDetail,
      callback,
      queryParameters: queryParameters,
    );
  }

  static Future<void> getPgcPageDetailAsync(
    PgcType pgcType,
    String? cursor,
    Function callback,
  ) async {
    var queryParameters = <String, Object>{
      ServiceConstants.query.device: "phone",
      ServiceConstants.query.fnval: "976",
      ServiceConstants.query.fnver: "0",
      ServiceConstants.query.fourk: "1",
      ServiceConstants.query.qn: "112",
    };
    switch (pgcType) {
      case PgcType.movie:
        queryParameters[ServiceConstants.query.name] =
            ServiceConstants.movieOperation;
        break;
      case PgcType.documentary:
        queryParameters[ServiceConstants.query.name] =
            ServiceConstants.documentaryOperation;
        break;
      case PgcType.tV:
        queryParameters[ServiceConstants.query.name] =
            ServiceConstants.tvOperation;
        break;
      default:
        break;
    }

    if (cursor != null && cursor.isNotEmpty) {
      queryParameters[ServiceConstants.query.cursor] = cursor;
    }

    await Http().get(
      ApiConstants.pgc.pageDetail,
      callback,
      queryParameters: _Parameters._getQueryParameters(queryParameters),
    );
  }
}
