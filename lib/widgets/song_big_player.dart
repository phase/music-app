import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';

class BigSongPlayer extends StatefulWidget {
  final Client client;
  final Song song;

  BigSongPlayer(this.client, this.song);

  @override
  _BigSongPlayerState createState() => new _BigSongPlayerState();
}

class _BigSongPlayerState extends State<BigSongPlayer> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new FutureBuilder<FadeInImage>(
              future: () {
                return widget.client
                    .getSongArtwork(widget.song.id, width * 0.75);
              }(),
              builder:
                  (BuildContext context, AsyncSnapshot<FadeInImage> snapshot) {
                if (snapshot.hasData) {
                  var image = snapshot.data;
                  return image;
                } else {
                  return const Placeholder(
                    fallbackHeight: 300.0,
                    fallbackWidth: 300.0,
                  );
                }
              },
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              width: width * 0.9,
              child: new Text(
                widget.song.name,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: new TextStyle(
//                  fontSize: (WIDTH * 0.7) / widget.song.name.length * 3,
                  fontSize: 25.0,
                ),
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              width: width * 0.9,
              child: new FutureBuilder<String>(
                future: widget.song.getMeta(widget.client),
                builder: (context, snapshot) {
                  return new Text(
                    snapshot.hasData ? snapshot.data : "",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: const Color(0x90FFFFFF),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
