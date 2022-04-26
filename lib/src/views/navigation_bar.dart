import 'package:flutter/material.dart';
import 'package:selfradio/src/views/song_list.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBar> {
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

  void onItemTapped(int index) {
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
        onTap: onItemTapped,
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