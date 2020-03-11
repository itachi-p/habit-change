import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginVer2 extends StatefulWidget {
  GoogleLoginVer2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GoogleLoginVer2State createState() => _GoogleLoginVer2State();
}

class _GoogleLoginVer2State extends State {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

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

  Future signInWithGoogle() async {
    //サインイン画面表示
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    //firebase側に登録
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    //userのid取得
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    login();
  }

  //サインアウト
  void signOutGoogle() async {
    await googleSignIn.signOut();
    logout();
    print("User Sign Out Google");
  }

  @override
  Widget build(BuildContext context) {
    Widget logoutText = Text(
      "You are signed out of Google.",
      style: TextStyle(fontSize: 20, backgroundColor: Colors.deepOrange),
    );
    Widget loginText = Text(
      "You are logged into Google.",
      style: TextStyle(fontSize: 20, backgroundColor: Colors.blue),
    );

    Widget loginButton = RaisedButton(
      child: Text("Sign in with Google"),
      color: Color(0xFFDD4B39),
      textColor: Colors.white,
      onPressed: signInWithGoogle,
    );
    Widget logoutButton = RaisedButton(
        child: Text("Sign out"),
        color: Color(0xFFDD4B39),
        textColor: Colors.white,
        onPressed: signOutGoogle);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loggedIn ? loginText : logoutText,
          loggedIn ? logoutButton : loginButton,
        ],
      ),
    );
  }
}
