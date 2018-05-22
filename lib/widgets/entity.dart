import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';

class EntityWidget extends StatelessWidget {
  final Client client;
  final DisplayableEntity entity;

  EntityWidget(this.client, this.entity);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(4.0),
      child: new Column(
        children: <Widget>[
          new Container(
            width: 150.0,
            height: 150.0,
            child: new FutureBuilder<FadeInImage>(
              future: () {
                if (entity is Song)
                  return client.getSongArtwork((entity as Song).id, 150.0);
                else if (entity is Album)
                  return client.getAlbumArtwork((entity as Album).id, 150.0);
                else if (entity is Playlist)
                  return client.getPlaylistArtwork(
                      (entity as Playlist).id, 150.0);
                return null;
              }(),
              builder:
                  (BuildContext context, AsyncSnapshot<FadeInImage> snapshot) {
                if (snapshot.hasData) {
                  var image = snapshot.data;
                  return image;
                } else {
                  return const Placeholder(
                    fallbackHeight: 150.0,
                    fallbackWidth: 150.0,
                  );
                }
              },
            ),
          ),
          new Container(
            width: 140.0,
            child: new Text(
              entity.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15.0),
            ),
          ),
          new Container(
            width: 140.0,
            child: new FutureBuilder<String>(
              future: entity.getMeta(client),
              builder: (context, snapshot) {
                return new Text(
                  snapshot.hasData ? snapshot.data : "",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10.0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
