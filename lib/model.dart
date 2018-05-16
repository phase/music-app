// should match model.kt in the server

class DisplayableEntity {
  final String name = "null";

  String getMeta() => "null";
}

class Song implements DisplayableEntity {
  final int id;
  final String name;
  final List<int> artistIds;

  Song(this.id, this.name, this.artistIds);

  Song.named({this.id, this.name, this.artistIds});

  factory Song.fromJson(Map<String, dynamic> json) {
    return new Song.named(
      id: json["id"],
      name: json["name"],
      artistIds: json["artistIds"],
    );
  }

  @override
  String getMeta() {
    return artistIds.toString();
  }
}

class Artist {
  final int id;
  final String name;

  Artist(this.id, this.name);

  Artist.named({this.id, this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return new Artist.named(
      id: json["id"],
      name: json["name"],
    );
  }
}

class Album implements DisplayableEntity {
  final int id;
  final String name;
  final List<int> artistIds;
  final List<int> songIds;

  Album(this.id, this.name, this.artistIds, this.songIds);

  Album.named({this.id, this.name, this.artistIds, this.songIds});

  factory Album.fromJson(Map<String, dynamic> json) {
    return new Album.named(
      id: json["id"],
      name: json["name"],
      artistIds: json["artistIds"],
      songIds: json["songIds"],
    );
  }

  @override
  String getMeta() {
    return artistIds.toString();
  }
}

class User {
  final int id;
  final String name;

  User(this.id, this.name);

  User.named({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User.named(
      id: json["id"],
      name: json["name"],
    );
  }
}

class Playlist implements DisplayableEntity {
  final int id;
  final String name;
  final int userId;
  final List<int> songIds;

  Playlist(this.id, this.name, this.userId, this.songIds);

  Playlist.named({this.id, this.name, this.userId, this.songIds});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return new Playlist.named(
      id: json["id"],
      name: json["name"],
      userId: json["userId"],
      songIds: json["songIds"],
    );
  }

  @override
  String getMeta() {
    return userId.toString();
  }
}
