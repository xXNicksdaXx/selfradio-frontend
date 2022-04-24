import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class Song {
  final String id;
  final String title;
  final List<String> artist;
  final String path;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json['_id'],
        title: json['title'],
        artist: json['artist'],
        path: json['path']
    );
  }
}

Future<List<Song>> fetchAllSongs() async {
  final response = await http
      .get(Uri.parse('http://localhost:3000/song/find'));

  if(response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<Song> songs = List<Song>.from(jsonResponse.map(
            (song) => Song.fromJson(song) //decode song-json to song-object
    ));
    return songs;
  } else {
    throw Exception('Failed to fetch song');
  }
}