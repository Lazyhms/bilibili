import 'package:bilibili/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // 延迟
    Future.delayed(
      const Duration(seconds: 1),
      goToHomePage,
    );
  }

  void goToHomePage() {
    //跳转主页 且销毁当前页面
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const AppHome(),
      ),
      (Route<dynamic> rout) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/splash.jpg",
      fit: BoxFit.cover,
    );
  }
}
