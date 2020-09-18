import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';

class MyBooksViewModel with ChangeNotifier {
  int test = 5;
  final dbHelper = DatabaseHelper.instance;

  List<Book> _myBooks = [];

  get myBooks {
    return _myBooks;
  }

  set myBooks(List<Book> value) {
    _myBooks = value;
    notifyListeners();
  }

  MyBooksViewModel() {
    _getMyBooks();
  }

  _getMyBooks() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    List<Book> newBooks = [];
    allRows.forEach(
      (row) =>
          // print(row['details'])
          newBooks.add(
        Book.fromJson(jsonDecode(row['details']))
          ..effectStoragePath = row['effect_path'],
      ),
    );
    myBooks = newBooks;
  }
}
