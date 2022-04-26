import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../entities/song.dart';

class SongService {

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
}