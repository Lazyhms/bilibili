import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings {
  static const String project = 'bilibili';
  static const String fontFamily = 'bilibili';

  static bool enabledSystemUIMode = true;
  static bool preferredOrientations = true;
}

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingWidgetState();
}

class SettingWidgetState extends State<SettingWidget> {
  @override
  initState() {
    super.initState();

    ///  沉浸式状态栏
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        addAutomaticKeepAlives: true,
        children: [
          Row(
            children: [
              const Text('强制竖屏'),
              Switch(
                activeColor: Colors.blue,
                value: Settings.preferredOrientations,
                onChanged: (val) async {
                  setPreferredOrientations(val);
                },
              ),
            ],
          ),
          Row(
            children: [
              const Text('隐藏状态栏'),
              Switch(
                activeColor: Colors.blue,
                value: Settings.enabledSystemUIMode,
                onChanged: (val) async {
                  setEnabledSystemUIMode(val);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  /// 是否强制竖屏
  Future<void> setPreferredOrientations(bool val) async {
    if (val) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }

    setState(() {
      Settings.preferredOrientations = val;
    });
  }

  /// 是否隐藏状态栏
  Future<void> setEnabledSystemUIMode(bool val) async {
    if (val) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [],
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ],
      );
    }

    setState(() {
      Settings.enabledSystemUIMode = val;
    });
  }
}
