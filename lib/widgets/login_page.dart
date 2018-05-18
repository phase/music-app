import 'package:flutter/material.dart';
import '../client.dart';

typedef LoginCallback(String username, String password);

class LoginPage extends StatefulWidget {
  final LoginCallback callback;

  LoginPage(this.callback);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: new Scaffold(
        backgroundColor: Colors.orange,
        body: new Container(
          padding: new EdgeInsets.fromLTRB(40.0, 120.0, 40.0, 40.0),
          child: new Column(
            children: <Widget>[
              new Center(
                child: new Text(
                  "Jadon's Music Service",
                  style: const TextStyle(fontSize: 35.0),
                ),
              ),
              new TextField(
                autocorrect: false,
                autofocus: true,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "Username",
                ),
                onChanged: (String s) {
                  username = s;
                },
              ),
              new TextField(
                autocorrect: false,
                obscureText: true,
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  hintText: "Password",
                ),
                onChanged: (String s) {
                  password = s;
                },
              ),
              new FlatButton(
                color: Colors.deepOrange[600],
                onPressed: () {
                  print("button clicked $username $password");
                  widget.callback(username, password);
                },
                child: const Text("Log In"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
