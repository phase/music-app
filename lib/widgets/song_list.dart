import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';

class EntityRowWidget extends StatelessWidget {
  final Client client;
  final List<DisplayableEntity> entities;

  EntityRowWidget(this.client, this.entities);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var entity in entities) {
      children.add(new Container(
        padding: new EdgeInsets.all(4.0),
        child: new Column(
          children: <Widget>[
            new FutureBuilder<FadeInImage>(
              future: () {
                if (entity is Song)
                  return client.getSongArtwork(entity.id, 150.0);
                else if (entity is Album)
                  return client.getAlbumArtwork(entity.id, 150.0);
                else if (entity is Playlist)
                  return client.getPlaylistArtwork(entity.id, 150.0);
                return null;
              }(),
              builder: (BuildContext context, AsyncSnapshot<FadeInImage> snapshot) {
                if (snapshot.hasData) {
                  var image = snapshot.data;
                  return image;
                } else {
                  return const Placeholder(fallbackHeight: 150.0, fallbackWidth: 150.0,);
                }
              },
            ),
            new Text(
              entity.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15.0),
            ),
            new Text(
              entity.getMeta(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10.0),
            )
          ],
        ),
      ));
    }
    return new Container(
      height: 200.0,
      child: new ListView(scrollDirection: Axis.horizontal, children: children),
    );
  }
}

//class Entity
