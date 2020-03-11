import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
// TODO flutter_facebook_loginが使える状態になっていない(ソースコードではなく設定側の問題)

class BuildFacebookLoginButton extends StatefulWidget {
  BuildFacebookLoginButton({
    Key key,
    this.title,
  }) : super(
          key: key,
        );

  final String title;

  @override
  _BuildFacebookLoginButtonState createState() =>
      _BuildFacebookLoginButtonState();
}

class _BuildFacebookLoginButtonState extends State {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookSignIn = FacebookLogin();

  Future signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    // Facebookの認証画面が開く
    final facebookLoginResult = await facebookLogin.logIn((['email']));

    // Firebaseのユーザー情報と連携
    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: facebookLoginResult.accessToken.token,
    );

    // Firebaseのユーザー情報を取得
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    login();
  }

  bool loggedIn = false;

  void login() {
    setState(() {
      loggedIn = true;
    });
  }

  void logout() {
    setState(() {
      loggedIn = false;
    });
  }

  void signOutFacebook() async {
    await facebookSignIn.logOut();
    logout();
    print("User Sign Out Facebook");
  }

  @override
  Widget build(BuildContext context) {
    Widget logoutText = Text(
      "You are signed out of Facebook.",
      style: TextStyle(fontSize: 20, backgroundColor: Colors.deepOrange),
    );
    Widget loginText = Text(
      "You are logged into Facebook.",
      style: TextStyle(fontSize: 20, backgroundColor: Colors.blue),
    );

    Widget loginBtnFb = RaisedButton(
      child: Text("Sign in with Facebook"),
      color: Color(0xFF3B5998),
      textColor: Colors.white,
      onPressed: signInWithFacebook,
    );

    Widget logoutBtnFb = RaisedButton(
      child: Text("Sign out with Facebook"),
      color: Color(0xFF3B5998),
      textColor: Colors.white,
      onPressed: signOutFacebook,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loggedIn ? loginText : logoutText,
          loggedIn ? logoutBtnFb : loginBtnFb,
        ],
      ),
    );
  }
}
