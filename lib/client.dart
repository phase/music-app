import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' show json;
import 'model.dart';

// HTTP Client that connects to the REST server
class Client {
  final String url;
  String apiUrl;

  Client(this.url) {
    this.apiUrl = url + "/api/v1/";
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

}
