import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';

class BookshelfDetailsViewModel with ChangeNotifier {
  BuildContext context;
  static const MethodChannel nativeCallChannel =
      const MethodChannel('com.storytellers.storytellers/nativecall');

  final dbHelper = DatabaseHelper.instance;

  final Book book;

  BookshelfDetailsViewModel(this.book, this.context);

  launchDeepAR(String effect) async {
    // print(effect);

    String info;
    try {
      info = await nativeCallChannel.invokeMethod("pushPop", {"text": effect});
      _updateDB(info);
    } on PlatformException {
      info = "Failed to push native view.";
    }
  }

  void _updateDB(String path) async {
//Change to json stringify, save timestamp as Key

    String now = DateTime.now().millisecondsSinceEpoch.toString();
    book.videoPaths[now] = path;
    String _videoPaths = jsonEncode(book.videoPaths);

    // book.videoPaths.add(path);
    // String _videoPaths = book.stringifyVideoPaths();
    // print(_videoPaths);

    //List<String> videoPaths = book.videoPaths;
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: book.dbRowId,
      DatabaseHelper.columnVideoPaths: _videoPaths
    };
    final rowsAffected = await dbHelper.update(row);
    // if (rowsAffected == 0) {
    //   final id = await dbHelper.insert(row);
    //   print('inserted row id: $id');
    // }
    print('updated $rowsAffected row(s)');

    context.read<SavedBooksProvider>().savedNewVideo();
  }
}
