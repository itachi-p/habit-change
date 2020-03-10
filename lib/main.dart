import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'habit change_Google Sign in',
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
      body: _firebaseUser == null ? _buildGoogleSignInButton() : _layoutBody(),
    );
  }

  // Login with email and password
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

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

  Widget _buildGoogleSignInButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: RaisedButton(
            child: Text("Google Sign In"),
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

  Widget _layoutBody() {
    return Center(
      child: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 24.0),
              TextFormField(
                controller: emailInputController,
                decoration: const InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: passwordInputController,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              Center(
                child: RaisedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    var email = emailInputController.text;
                    var password = passwordInputController.text;
                    // ログイン処理(別途Firebase管理画面でユーザー登録が必要)
                    return _signIn(email, password)
                        .then((AuthResult result) => print(result.user))
                        .catchError((e) => print(e));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<AuthResult> _signIn(String email, String password) async {
  final _firebaseAuth = FirebaseAuth.instance;
  final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
  print("User id is ${result.user.uid}");
  return result;
}
