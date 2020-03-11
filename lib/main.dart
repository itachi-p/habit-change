import 'package:flutter/material.dart';

import 'build_facebook_login_button.dart';
import 'build_google_login_button.dart';
import 'build_mail_login_form.dart';
import 'google_login.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Various login tests',
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
      appBar: AppBar(title: Text('Various login tests')),
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('----------'),
          ),
          BuildFacebookLoginButton(),
        ],
      ),
    );
  }
}
