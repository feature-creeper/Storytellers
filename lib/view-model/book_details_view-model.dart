import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';
import 'package:path_provider/path_provider.dart';

class BookDetailsViewModel with ChangeNotifier {
  final Book book;
  BookDetailsViewModel(this.book);

  final dbHelper = DatabaseHelper.instance;

  void tappedAddToMyBooks() {
    final StorageReference ref =
        FirebaseStorage().ref().child(book.effectStoragePath);
    _downloadFile(ref);
  }

  void _saveBookLocally(String effectPath) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnBookDetails: jsonEncode(book),
      DatabaseHelper.columnEffectPath: effectPath
    };
    final id = await dbHelper.insert(row);
    print("ROW ADDED ID: $id");
  }

  _errorDownloading() {
    //Do something
  }

  _success(String effectPath) {
    _saveBookLocally(effectPath);
  }

  Future<void> _downloadFile(StorageReference ref) async {
    Directory dir = await getApplicationDocumentsDirectory();

    String name = await ref.getName();
    String path = dir.path + '/' + name;

    final StorageFileDownloadTask task = ref.writeToFile(File(path));

//TODO: SORT OUT ERROR HANDLING
//https://www.woolha.com/tutorials/flutter-using-streamcontroller-and-streamsubscription
    task.future.asStream().listen(
      (event) {
        print('TOTAL BYTES ${event.totalByteCount}');
      },
      onDone: () {
        _success(name);
      },
      onError: (error) {},
    ); //.onDone(_success(name));
  }
}

//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_storage/example/lib/main.dart#L84
