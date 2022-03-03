library apiservice;

import 'package:bilibili/constants/api.dart';
import 'package:bilibili/constants/global.dart';
import 'package:bilibili/constants/service.dart';
import 'package:bilibili/util/http.dart';

part 'api.pgc.dart';

part 'api.recommend.dart';

class _Parameters {
  static Map<String, Object> _getQueryParameters(
    Map<String, Object> other, {
    Client client = Client.ios,
  }) {
    if (Client.ios == client) {
      other.addAll(_defaultIOSParameters);
    } else if (Client.android == client) {
      other.addAll(_defaultAndroidParameters);
    } else {
      other.addAll(_defaultWebParameters);
    }

    var token = '';
    if (token.isNotEmpty) {
      other[ServiceConstants.query.accessKey] = token;
    }
    var sign = '';
    if (sign.isNotEmpty) {
      other[ServiceConstants.query.sign] = sign;
    }
    return other;
  }

  static final Map<String, Object> _defaultIOSParameters = <String, Object>{
    ServiceConstants.query.appKey: ServiceConstants.keys.iOSKey,
    ServiceConstants.query.mobileApp: "iphone",
    ServiceConstants.query.platform: 'ios',
    ServiceConstants.query.timeStamp:
        DateTime.now().toLocal().millisecondsSinceEpoch
  };

  static final Map<String, Object> _defaultAndroidParameters = <String, Object>{
    ServiceConstants.query.appKey: ServiceConstants.keys.androidKey,
    ServiceConstants.query.mobileApp: "android",
    ServiceConstants.query.platform: 'android',
    ServiceConstants.query.timeStamp:
        DateTime.now().toLocal().millisecondsSinceEpoch
  };

  static final Map<String, Object> _defaultWebParameters = <String, Object>{
    ServiceConstants.query.appKey: ServiceConstants.keys.webKey,
    ServiceConstants.query.platform: 'web',
    ServiceConstants.query.timeStamp:
        DateTime.now().toLocal().millisecondsSinceEpoch
  };
}
