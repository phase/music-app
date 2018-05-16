import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';
import 'song_list.dart';

class HomePage extends StatelessWidget {
  final Client client;

  HomePage(this.client);

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: new EdgeInsets.all(20.0),
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
          child: const Text(
            "Recently Played",
            style: const TextStyle(fontSize: 30.0),
          ),
        ),
        new EntityListWidget([
          Song(1, "Alpha", [1, 2]),
          Song(2, "Beta", [1]),
          Song(3, "Gamma", [2]),
          Song(4, "Delta", [1, 2]),
          Song(5, "Elipson", [1]),
          Song(6, "Zeta", [2]),
        ]),
        new Container(
          padding: new EdgeInsets.fromLTRB(00.0, 0.0, 0.0, 20.0),
          child: const Text(
            "New Music",
            style: const TextStyle(fontSize: 30.0),
          ),
        ),
        new EntityListWidget([
          Song(7, "Eta", [1, 2]),
          Song(8, "Theta", [1]),
          Song(9, "Iota", [2]),
          Song(10, "Kappa", [1, 2]),
          Song(11, "Lambda", [1]),
          Song(12, "Mu", [2]),
        ]),
      ],
    );
  }
}
