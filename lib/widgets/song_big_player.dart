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
  double duration = 0.0;

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
                  return new Placeholder(
                    fallbackHeight: width * 0.75,
                    fallbackWidth: width * 0.75,
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
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              width: width * 0.75,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Text("0:00"),
                  new Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey[800],
                    value: this.duration,
                    onChanged: (double value) {
                      setState(() {
                        this.duration = value;
                      });
                      print((value).roundToDouble());
                    },
                    min: 0.0,
                    max: 1000.0, // song duration
                  ),
                  new Text("9:99"),
                ],
              ),
            ),
            new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
              width: width * 0.8,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.skip_previous),
                    onPressed: () {
                      print("skip previous button pressed");
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  new Container(
                    child: new IconButton(
                      icon: new Icon(Icons.play_arrow),
                      onPressed: () {
                        print("play button pressed");
                      },
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(100.0),
                      color: Colors.green,
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.skip_next),
                    onPressed: () {
                      print("skip next button pressed");
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
