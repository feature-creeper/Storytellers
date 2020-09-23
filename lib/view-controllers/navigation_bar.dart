import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-controllers/my_books.dart';
import 'package:storytellers/view-controllers/profile.dart';
import 'package:storytellers/view-model/home_view-model.dart';
import 'package:storytellers/view-model/my_books_view-model.dart';
import 'package:storytellers/view-model/profile_view-model.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';
import 'home.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int navIndex = 0;

  Widget _homePage;
  ChangeNotifierProvider<MyBooksViewModel> _myBooks;
  Widget _myVideos;

  void setPage(int index) {
    setState(() {
      navIndex = index;
    });
  }

  @override
  void initState() {
    _homePage = ChangeNotifierProvider<HomeViewModel>(
        create: (_) => HomeViewModel(), builder: (_, __) => MyHomePage());
    _myBooks = ChangeNotifierProvider<MyBooksViewModel>(
        create: (_) => MyBooksViewModel(),
        builder: (context, child) => MyBooks());
    _myVideos =
        ChangeNotifierProxyProvider<SavedBooksProvider, ProfileViewModel>(
            create: (context) => ProfileViewModel(),
            update: (context, value, vm) => ProfileViewModel()..queryAll(),
            builder: (context, child) => Profile());
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
      body: IndexedStack(
        children: [_homePage, _myBooks, _myVideos],
        index: navIndex,
      ),
    );
  }
}
