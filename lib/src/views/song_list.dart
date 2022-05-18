import 'package:flutter/material.dart';
import 'package:selfradio/src/api/locator.dart';
import 'package:selfradio/src/api/song_service.dart';
import 'package:selfradio/src/controller/adjustable_scroll_controller.dart';
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
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: ListTile(
                      leading: const Icon(Icons.audiotrack_rounded),
                      title: Text(snapshot.data![index].title),
                      subtitle: Text(snapshot.data![index].artist.join(", ")),
                      trailing: PopupMenuButton(
                        icon: const Icon(Icons.more_vert),
                        iconSize: 16,
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem(
                            child: Text("Abspielen"),
                            value: 1,
                          ),
                          const PopupMenuItem(
                            child: Text("Zur Warteschlange hinzufügen"),
                            value: 2,
                          )
                        ],
                        tooltip: "",
                      ),
                    ),
                  );
                },
              controller: AdjustableScrollController(),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        }
    );
  }
}