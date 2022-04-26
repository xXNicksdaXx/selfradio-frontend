import 'package:flutter/material.dart';
import 'package:selfradio/src/api/locator.dart';
import 'package:selfradio/src/api/song_service.dart';
import '../entities/song.dart';

class SongList extends StatefulWidget{
  const SongList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SongListState();
  }
}

class SongListState extends State<SongList> {

  SongService songService = serviceLocator.get<SongService>();
  late Future<List<Song>> songs;

  @override
  void initState() {
    super.initState();

    songs = songService.fetchAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Song>>(
        future: songs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, int index) {
                  return Text(snapshot.data![index].artist.toString());
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}