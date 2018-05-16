import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';

class EntityListWidget extends StatelessWidget {
  final List<DisplayableEntity> entities;

  EntityListWidget(this.entities);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var entity in entities) {
      children.add(new Container(
        padding: new EdgeInsets.all(4.0),
        child: new Column(
          children: <Widget>[
            new Container(
              color: Colors.blue,
              width: 150.0,
              height: 150.0,
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
