import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'change habits',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The challenge of changing habits')),
      body: _layoutBody(),
    );
  }

  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

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
                    // ここにログイン処理を書く
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
