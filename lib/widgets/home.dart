import 'package:flutter/material.dart';
import '../client.dart';
import 'song_list.dart';

class HomePage extends StatefulWidget {
  final Client client;

  HomePage(this.client);

  @override
  _HomePageState createState() => new _HomePageState(this.client);
}

class _HomePageState extends State<HomePage> {
  final Client client;
  Map<String, dynamic> stats;

  _HomePageState(this.client) {
    this.client.getStats().then((map) {
      setState(() {
        print(map);
        this.stats = map;
      });
    }, onError: () {
      print("Retriving Stats in the _HomePageState constuctor failed!");
    });
  }

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
        stats == null
            ? null
            : new EntityRowWidget(widget.client, stats["recentCount"] as int,
                (offset) {
                final entity = widget.client.getRecentEntity(offset);
                return entity;
              }),
        new Container(
          padding: new EdgeInsets.fromLTRB(00.0, 0.0, 0.0, 20.0),
          child: const Text(
            "New Music",
            style: const TextStyle(fontSize: 30.0),
          ),
        ),
        stats == null
            ? null
            : new EntityRowWidget(widget.client, stats["newCount"] as int,
                (offset) {
                final entity = widget.client.getNewEntity(offset);
                return entity;
              }),
      ].where((c) => c != null).toList(),
    );
  }
}
