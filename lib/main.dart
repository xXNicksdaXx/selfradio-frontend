import 'package:flutter/material.dart';
import 'package:selfradio/models/song.dart';

void main() => runApp(const Selfradio());

class Selfradio extends StatelessWidget {
  const Selfradio({Key? key}) : super(key: key);

  static const String title = 'Selfradio';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: title,
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  static const List<Widget> pages = <Widget>[
    Text(
      'Home',
    ),
    Text(
      'Song',
    ),
    SongList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfradio'),
        backgroundColor: Colors.black87,
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // Shifting
        currentIndex: selectedIndex,
        selectedIconTheme: const IconThemeData(color: Colors.deepOrangeAccent, size: 33),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.audiotrack_rounded),
            label: 'Song',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Playlist',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class SongList extends StatefulWidget{
  const SongList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SongListState();
  }
}

class SongListState extends State<SongList>{

  late Future<List<Song>> songs;

  @override
  void initState() {
    super.initState();
    songs = fetchAllSongs();
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
                  return Text(snapshot.data![index].title);
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
