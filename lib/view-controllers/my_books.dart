import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-controllers/bookshelf_detail.dart';
import 'package:storytellers/view-model/bookshelf_details_view-model.dart';
import 'package:storytellers/view-model/my_books_view-model.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  List<Book> myBooks = [];

  _goToBookDetail(int index) {
    Widget provider = ChangeNotifierProvider(
      create: (_) => BookshelfDetailsViewModel(myBooks[index]),
      builder: (_, __) => BookShelfDetail(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    myBooks = context.watch<MyBooksViewModel>().myBooks;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: myBooks.length,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () => _goToBookDetail(index),
              leading: Icon(Icons.account_circle),
              title: Text(myBooks[index].title),
              subtitle: Text(myBooks[index].author),
            );
          }),
    );
  }
}
