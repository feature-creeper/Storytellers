import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-controllers/bookshelf_detail.dart';
import 'package:storytellers/view-model/bookshelf_details_view-model.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  _goToBookDetail() {
    Widget provider = ChangeNotifierProvider(
      create: (_) => BookshelfDetailsViewModel(),
      builder: (_, __) => BookShelfDetail(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => provider),
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
