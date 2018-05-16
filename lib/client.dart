import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;
import 'dart:typed_data';
import 'model.dart';

// HTTP Client that connects to the REST server
class Client {
  final String url;
  String apiUrl;
  String downloadUrl;

  Client(this.url) {
    this.apiUrl = url + "/api/v1/";
    this.downloadUrl = url + "/download/";
  }

  Future<Song> getSong(int id) async {
    final response = await http.get(apiUrl + "song/" + id.toString());
    final responseJson = json.decode(response.body);
    return new Song.fromJson(responseJson);
  }

  Future<Artist> getArtist(int id) async {
    final response = await http.get(apiUrl + "artist/" + id.toString());
    final responseJson = json.decode(response.body);
    return new Artist.fromJson(responseJson);
  }

  Future<Album> getAlbum(int id) async {
    final response = await http.get(apiUrl + "album/" + id.toString());
    final responseJson = json.decode(response.body);
    return new Album.fromJson(responseJson);
  }

  // Temp
  final Uint8List transparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE
  ]);

  Future<Image> getSongArtwork(int id, double size) async {
    var c = new Completer<Image>();
    c.complete(new Image.memory(transparentImage, width: size, height: size));
    return c.future;
  }

  Future<Image> getAlbumArtwork(int id, double size) async {
    var c = new Completer<Image>();
    c.complete(new Image.memory(transparentImage, width: size, height: size));
    return c.future;
  }

  Future<Image> getPlaylistArtwork(int id, double size) async {
    var c = new Completer<Image>();
    c.complete(new Image.memory(transparentImage, width: size, height: size));
    return c.future;
  }
}
