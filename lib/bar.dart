import 'package:bilibili/settings.dart';
import 'package:flutter/material.dart';

class HomeBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HomeBar({
    Key? key,
    this.height = 46.0,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<StatefulWidget> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(left: 15.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(17)),
                border: Border.all(width: 1, color: Colors.grey),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/default_avatar.png"),
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          widget.scaffoldKey.currentState!.openDrawer();
        },
      ),
      title: GestureDetector(
        child: Opacity(
          opacity: 0.15,
          child: Container(
            height: 30,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          ),
        ),
        onTap: () {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(builder: (contex) => SearchIndexPage()),
          // ); //改为侧滑切换动画
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            IconData(0xe672, fontFamily: Settings.fontFamily),
            color: Colors.grey,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: Text("暂未开放"),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            IconData(0xe6df, fontFamily: Settings.fontFamily),
            color: Colors.grey,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.blueGrey,
                content: Text("暂未开放"),
              ),
            );
          },
        ),
      ],
    );
  }
}
