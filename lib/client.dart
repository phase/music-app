import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert' show json;
import 'dart:typed_data';
import 'model.dart';

typedef LoginCallback(String /*?*/ token);

// HTTP Client that connects to the REST server
class Client {
  final String url;
  String apiUrl;
  String downloadUrl;


  Client(this.url) {
    this.apiUrl = url + "/api/v1/";
    this.downloadUrl = url + "/download/";
  }

  // token file

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _tokenFile async {
    final path = await _localPath;
    return new File('$path/MUSIC_CLIENT_TOKEN.txt');
  }

  Future<FileSystemEntity> deleteToken() async {
    final file = await _tokenFile;
    return file.delete();
  }

  Future<File> writeToken(String token) async {
    final file = await _tokenFile;
    return file.writeAsString(token);
  }

  Future<String> readToken() async {
    try {
      final file = await _tokenFile;
      String token = await file.readAsString();
      return token;
    } catch (e) {
      return null;
    }
  }

  // auth

  Future<bool> checkToken() async {
    final file = await _tokenFile;
    if (await file.exists()) {
      final token = await readToken();
      return await validateToken(token);
    } else {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final token = await _login(username, password);
    if (token != null) {
      writeToken(token);
      return true;
    } else {
      return false;
    }
  }

  // connecting to the server

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

  // These probably don't need to be Futures

  Future<FadeInImage> getSongArtwork(int id, double size) async {
    final c = new Completer<FadeInImage>();
    c.complete(new FadeInImage.memoryNetwork(
      placeholder: transparentImage,
      image: downloadUrl + "artwork/song/$id",
      width: size,
      height: size,
    ));
    return c.future;
  }

  Future<FadeInImage> getAlbumArtwork(int id, double size) async {
    var c = new Completer<FadeInImage>();
    c.complete(new FadeInImage.memoryNetwork(
      placeholder: transparentImage,
      image: downloadUrl + "artwork/album/$id",
      width: size,
      height: size,
    ));
    return c.future;
  }

  Future<FadeInImage> getPlaylistArtwork(int id, double size) async {
    var c = new Completer<FadeInImage>();
    c.complete(new FadeInImage.memoryNetwork(
      placeholder: transparentImage,
      image: downloadUrl + "artwork/playlist/$id",
      width: size,
      height: size,
    ));
    return c.future;
  }

  Future<bool> validateToken(String token) async {
    final response = await http.get(apiUrl + "validate?token=" + token);
    final responseJson = json.decode(response.body);
    return responseJson["valid"];
  }

  Future<String> _login(String username, String password) async {
    print("Client#_login called");
    // TODO: Post request weren't working on the server side
    final response =
        await http.get(apiUrl + "login?username=$username&password=$password");
    final responseJson = json.decode(response.body) as Map<String, dynamic>;
    print(responseJson);
    if (responseJson.containsKey("token"))
      return responseJson["token"] as String;
    return null;
  }
}
