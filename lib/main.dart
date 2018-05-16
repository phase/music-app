import 'package:flutter/material.dart';
import 'model.dart';
import 'client.dart';

// main widgets
import 'widgets/home.dart';

void main() => runApp(new MusicApp());

class MusicApp extends StatelessWidget {
  final Client client = new Client("http://local.jadon.io:2345");

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
          new DefaultTabController(
            length: 3,
            child: new Scaffold(
              appBar: new AppBar(
                title: const Text("Music"),
                bottom: new TabBar(
                  tabs: [
                    new Tab(text: "Home"),
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
                      new Icon(Icons.library_music),
                      new Text("404")
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new Icon(Icons.account_box),
                      new Text("404")
                    ],
                  ),
                ],
              ),
            ),
          ),
//          new SongDock(),
        ],
      ),
    );
  }
}
