import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';

class SavedBooksProvider with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  SavedBooksProvider() {
    getMyBooks();
  }

  List<Book> _myBooks = [];

  get myBooks {
    return _myBooks;
  }

  set myBooks(List<Book> value) {
    _myBooks = value;
    notifyListeners();
  }

  savedNewVideo() {
    notifyListeners();
  }

  getMyBooks() async {
    final allRows = await dbHelper.queryAllRows();

    List<Book> newBooks = [];
    allRows.forEach((row) {
      print('row:$row');
      newBooks.add(Book.fromJson(jsonDecode(row['details']))
        ..effectStoragePath = row['effect_path']
        ..dbRowId = row['_id']
        ..videoPaths = jsonDecode(row['videos_paths']));
    });
    myBooks = newBooks;
  }
}
