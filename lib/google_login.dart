import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State {
  // Login with Google Sign-in
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser _firebaseUser;

  Future<FirebaseUser> _handleGoogleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    _firebaseUser = (await _auth.signInWithCredential(credential)).user;
    assert(_firebaseUser.email != null);
    assert(_firebaseUser.displayName != null);
    assert(!_firebaseUser.isAnonymous);
    assert(await _firebaseUser.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(_firebaseUser.uid == currentUser.uid);
    print("signed in " + _firebaseUser.displayName);
    return _firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RaisedButton(
            child: Text("Google Sign In(ver.1)"),
            onPressed: () {
              _handleGoogleSignIn().then((user) {
                setState(() {
                  _firebaseUser = user;
                });
              }).catchError((error) {
                print(error);
              });
            },
          ),
        ),
      ],
    );
  }
}
