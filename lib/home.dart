import 'package:bilibili/bangumi/bangumi.dart';
import 'package:bilibili/bar.dart';
import 'package:bilibili/channel/content.dart';
import 'package:bilibili/home/content.dart';
import 'package:bilibili/settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

class AppHome extends StatefulWidget {
  const AppHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Widget> _widgetOptionsItem;

  int _selectedIndex = 0;
  DateTime _lastClick = DateTime.now();

  @override
  void initState() {
    super.initState();

    _widgetOptionsItem = <Widget>[
      const HomeContent(),
      const Bangumi(),
      const ChannelContent(),
      Container(),
    ];
  }

  // 二次返回退出
  Future<bool> _checkDoubleClick() async {
    if (DateTime.now().difference(_lastClick) > const Duration(seconds: 1)) {
      _lastClick = DateTime.now();
      Fluttertoast.showToast(msg: "再按一次退出");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _checkDoubleClick,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: HomeBar(scaffoldKey: _scaffoldKey),
        body: Center(
          child: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptionsItem,
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(),
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        image: const DecorationImage(
                            image: AssetImage(
                              "images/tv_sign_out.png",
                            ),
                            fit: BoxFit.contain,
                            alignment: Alignment.bottomRight),
                      ),
                      accountName: const Text(
                        "未登陆",
                        style: TextStyle(fontSize: 17),
                      ),
                      //用户名字
                      accountEmail: Text(
                        "点击头像登陆",
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      //用户硬币，b币信息
                      currentAccountPicture: GestureDetector(
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage("images/default_avatar.png"),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                      ),
                      otherAccountsPictures: const <Widget>[
                        Icon(
                          IconData(0xe6d4, fontFamily: Settings.fontFamily),
                          color: Colors.white,
                          size: 20,
                        ),
                        Icon(
                          IconData(0xe690, fontFamily: Settings.fontFamily),
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                    ListTile(
                      selected: true,
                      leading: const Icon(
                          IconData(0xe661, fontFamily: Settings.fontFamily)),
                      title: const Text("主页"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //平均分配空间
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingWidget(),
                          ),
                        );
                      },
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.grey,
                          ),
                          Text(
                            "设置",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe661, fontFamily: Settings.fontFamily)),
              activeIcon:
                  Icon(IconData(0xe662, fontFamily: Settings.fontFamily)),
              label: "首页",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe664, fontFamily: Settings.fontFamily)),
              activeIcon:
                  Icon(IconData(0xe663, fontFamily: Settings.fontFamily)),
              label: "专题",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe666, fontFamily: Settings.fontFamily)),
              activeIcon:
                  Icon(IconData(0xe665, fontFamily: Settings.fontFamily)),
              label: "频道",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconData(0xe667, fontFamily: Settings.fontFamily)),
              activeIcon:
                  Icon(IconData(0xe668, fontFamily: Settings.fontFamily)),
              label: "我的",
            ),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.pink[300],
          onTap: (index) {
            if (index != _selectedIndex) {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}
