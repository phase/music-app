import 'package:flutter/material.dart';
import 'model.dart';
import 'client.dart';

// main widgets
import 'widgets/home.dart';
import 'widgets/song_dock.dart';
import 'widgets/login_page.dart';

void main() => runApp(new MusicApp());

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => new _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  final Client client = new Client("http://local.jadon.io:2345");
  SongDock currentSongDock;
  LoginPage loginPage;
  String token;

  _MusicAppState() {
    client.deleteToken();
    _checkToken();
  }

  _checkToken() {
    final validToken = client.checkToken();

    // yay nesting
    validToken.then((bool valid) {
      if (valid) {
        client.readToken().then((String token) {
          print("got token $token");
          this.token = token;
          setState(() {
            loginPage = null;
          });
        }, onError: () {
          setState(() {
            if (loginPage == null) {
              loginPage = new LoginPage(_login);
            }
          });
        });
      } else {
        setState(() {
          if (loginPage == null) {
            loginPage = new LoginPage(_login);
          }
        });
      }
    }, onError: () {
      setState(() {
        if (loginPage == null) {
          loginPage = new LoginPage(_login);
        }
      });
    });
  }

  _login(String username, String password) {
    print("_MusicAppState#_login called ($username, $password)");
    client.login(username, password).then((bool valid) {
      _checkToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Jadon's Music App",
      theme: new ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      home: new Stack(
        children: <Widget>[
          new DefaultTabController /* main app */ (
            length: 4,
            child: new Scaffold(
              appBar: new AppBar(
                title: const Text("Music"),
                bottom: new TabBar(
                  tabs: [
                    new Tab(text: "Home"),
                    new Tab(text: "Search"),
                    new Tab(text: "Playlists"),
                    new Tab(text: "Account"),
                  ],
                ),
              ),
              body: new TabBarView(
                children: <Widget>[
                  new HomePage(client),
                  new Column(
                    children: <Widget>[
                      new Icon(Icons.search),
                      new Text("404"),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Icon(Icons.library_music),
                      new Text("404"),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Icon(Icons.account_box),
                      new Text("404"),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: currentSongDock,
            ),
          ),
          loginPage
        ].where((c) => c != null).toList(),
      ),
    );
  }
}
