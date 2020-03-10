import 'package:flutter/material.dart';

import 'google_login.dart';
import 'google_login_ver2.dart';
import 'mail_pass_login.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'habit change - sign in',
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The challenge of changing habits')),
      body: Column(
        children: <Widget>[
          MailAndPassLogin(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('----------'),
          ),
          GoogleLogin(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('----------'),
          ),
          GoogleLoginVer2(),
        ],
      ),
    );
  }
}
