import 'package:bilibili/log.dart';
import 'package:bilibili/settings.dart';
import 'package:bilibili/splash.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // 确保完成
  WidgetsFlutterBinding.ensureInitialized();
  // 隐藏状态栏
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [],
  // );
  // 沉浸式状态栏
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  // );
  // 强制竖屏
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  // 设置日志项目名称
  Log.project = Settings.project;
  //
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        fontFamily: Settings.fontFamily,
      ),
      home: const Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
