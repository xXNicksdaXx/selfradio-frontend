import 'package:flutter/material.dart';

void main() => runApp(const Selfradio());

class Selfradio extends StatelessWidget {
  const Selfradio({Key? key}) : super(key: key);

  static const String _title = 'Selfradio';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Song',
      style: optionStyle,
    ),
    Text(
      'Playlist',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selfradio'),
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // Shifting
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrangeAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        enableFeedback: false,
        showSelectedLabels: false,
      ),
    );
  }

  // @override
  // // Widget build(BuildContext context) {
  // //   return Scaffold(
  // //     appBar: AppBar(
  // //       title: const Text('Selfradio'),
  //     ),
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.library_music_rounded),
  //           label: 'Queue',
  //           backgroundColor: Colors.black,
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.audiotrack_rounded),
  //           label: 'Song',
  //           backgroundColor: Colors.black,
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.list_rounded),
  //           label: 'Playlist',
  //           backgroundColor: Colors.black,
  //         ),
  //       ],
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: Colors.deepOrangeAccent,
  //       onTap: _onItemTapped,
  //     ),
  //   );
  // }
}

