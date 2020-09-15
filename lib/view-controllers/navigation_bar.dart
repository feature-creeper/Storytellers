import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-controllers/profile.dart';
import 'package:storytellers/view-model/home_view-model.dart';
import 'home.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int navIndex = 0;

  Widget _homePage;

  final _myVideos = Profile();

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
  void initState() {
    _homePage = ChangeNotifierProvider(
        create: (_) => HomeViewModel(), builder: (_, __) => MyHomePage());
    super.initState();
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
