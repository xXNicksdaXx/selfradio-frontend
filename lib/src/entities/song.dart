import 'dart:core';

class Song {
  final String id;
  final String title;
  final List<dynamic> artist;
  final String path;
  final bool favorite;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.path,
    required this.favorite
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
        id: json['_id'],
        title: json['title'],
        artist: json['artist'],
        path: json['path'],
        favorite: json['favorite']
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'artist': artist,
    'path': path,
    'favorite': favorite,
  };
}