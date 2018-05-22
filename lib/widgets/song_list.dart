import 'dart:async';
import 'package:flutter/material.dart';
import '../model.dart';
import '../client.dart';
import 'entity.dart';

typedef Future<DisplayableEntity> EntityProvider(int offset);

class EntityRowWidget extends StatefulWidget {
  final Client client;
  final int count;
  final EntityProvider provider;

  EntityRowWidget(this.client, this.count, this.provider);

  @override
  _EntityRowWidgetState createState() => new _EntityRowWidgetState();
}

class _EntityRowWidgetState extends State<EntityRowWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 200.0,
      child: new ListView.builder(
        itemCount: widget.count,
        itemBuilder: (context, index) {
          return new FutureBuilder<DisplayableEntity>(
            future: widget.provider(index),
            builder: (BuildContext context,
                AsyncSnapshot<DisplayableEntity> snapshot) {
              if (snapshot != null) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  return new EntityWidget(widget.client, snapshot.data);
                } else {
                  return const Placeholder(
                    fallbackHeight: 150.0,
                    fallbackWidth: 150.0,
                  );
                }
              } else {
                return const Placeholder(
                  fallbackHeight: 150.0,
                  fallbackWidth: 150.0,
                );
              }
            },
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
