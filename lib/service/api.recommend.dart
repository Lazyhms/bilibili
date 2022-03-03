part of apiservice;

class RecommendService {
  // 推荐
  static Future<void> getRecommendCardsAsync(
      int offset, Function callback) async {
    var queryParameters = _Parameters._getQueryParameters(<String, Object>{
      ServiceConstants.query.idx: offset,
      ServiceConstants.query.flush: 5,
      ServiceConstants.query.column: 4,
      ServiceConstants.query.device: "phone",
      ServiceConstants.query.deviceName: "iPhone 12",
      ServiceConstants.query.pull: offset == 0,
    });

    await Http().get(
      ApiConstants.home.recommend,
      callback,
      queryParameters: queryParameters,
    );
  }
}
