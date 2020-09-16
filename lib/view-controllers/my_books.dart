import 'package:flutter/material.dart';
import 'package:storytellers/view-controllers/my_books_detail.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  _goToBookDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyBooksDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: _goToBookDetail,
              leading: Icon(Icons.access_alarm),
              title: Text('Monkey book'),
            );
          }),
    );
  }
}
