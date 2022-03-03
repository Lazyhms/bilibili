import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String accountLogo = "images/login_logo_account.png";
  String passwordLogo = "images/login_logo_password.png";
  final FocusNode _passwordfocusnode = FocusNode();
  late String logo;
  String account = "";
  String password = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logo = accountLogo;
    _passwordfocusnode.addListener(_passwordListener);
  }

  Future<void> _passwordListener() async {
    //当光标在密码栏时切换logo
    if (_passwordfocusnode.hasFocus) {
      logo = passwordLogo;
      setState(() {});
    }
    if (!_passwordfocusnode.hasFocus) {
      logo = accountLogo;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登陆"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
            child: const Text("忘记密码?"),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false, //防止软键盘弹出而超出范围
      body: Container(
        color: const Color.fromRGBO(234, 234, 234, 1),
        //rgb:234,234,234
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: Image.asset(
                logo,
                gaplessPlayback: true,
              ),
            ),
            Container(
              //账号输入框
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                controller: TextEditingController.fromValue(TextEditingValue(
                  text: account,
                  selection: TextSelection.fromPosition(
                    //保持光标在最后面
                    TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: account.length,
                    ),
                  ),
                )),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                obscureText: false,
                //是否是密码
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: "你的手机号/邮箱", icon: Icon(Icons.person_outline)),
                onChanged: (text) {
                  setState(() {
                    account = text;
                    print("account" + account);
                  });
                },
              ),
            ),
            Container(
              //密码输入框
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                focusNode: _passwordfocusnode,
                controller: TextEditingController.fromValue(TextEditingValue(
                  text: password,
                  selection: TextSelection.fromPosition(
                    //保持光标在最后面
                    TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: password.length,
                    ),
                  ),
                )),
                maxLength: 16,
                keyboardType: TextInputType.text,
                obscureText: true,
                //是否是密码
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: "请输入密码", icon: Icon(Icons.lock)),
                onChanged: (text) {
                  setState(() {
                    password = text;
                    print("password " + password);
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: const Text("注册账号"),
                    borderSide: const BorderSide(
                      color: Colors.pink,
                      width: 1,
                    ),
                    textColor: Colors.pink,
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: const Text("登陆"),
                    color: Colors.pink[300],
                    textColor: Colors.white,
                    onPressed: _login,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          '要是真的能登陆就好了',
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 50,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.blue,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
          ),
        ),
      ),
    );
  }
}
