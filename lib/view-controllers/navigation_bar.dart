import 'package:flutter/material.dart';
import 'package:storytellers/view-controllers/my_videos.dart';

import '../main.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int navIndex = 0;

  final _homePage = MyHomePage();
  final _myVideos = MyVideos();

  void setPage(int index) {
    setState(() {
      navIndex = index;
    });
  }

  Widget _page() {
    switch (navIndex) {
      case 0:
        return _homePage;
        break;
      case 2:
        return _myVideos;
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Discover')),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text('Bookcase')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Me')),
        ],
        currentIndex: navIndex,
        fixedColor: Colors.deepPurple,
        onTap: setPage,
      ),
      body: _page(),
    );
  }
}
