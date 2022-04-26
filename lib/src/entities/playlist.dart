import 'dart:core';

import 'package:selfradio/src/entities/song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final List<Song> songs;

  const Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.songs,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        songs: json['songs'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'songs': songs,
  };
}