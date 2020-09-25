import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';

class BookDetailsViewModel with ChangeNotifier {
  final Book book;
  final BuildContext context;

  BookDetailsViewModel(this.book, this.context) {
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      textDirection: TextDirection.rtl,
      isDismissible: false,
    );

    pr.style(
//      message: 'Downloading file...',
      message: 'Downloading',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  ProgressDialog pr;

  final dbHelper = DatabaseHelper.instance;

  void tappedAddToMyBooks() {
    final StorageReference ref =
        FirebaseStorage().ref().child(book.effectStoragePath);
    _downloadFile(ref);
  }

  void _saveBookLocally(String effectPath) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnBookDetails: jsonEncode(book),
      DatabaseHelper.columnEffectPath: effectPath,
      DatabaseHelper.columnVideoPaths: jsonEncode({})
    };
    final id = await dbHelper.insert(row);
    print("ROW ADDED ID: $id");

    context.read<SavedBooksProvider>().getMyBooks();
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

    pr.show();

//TODO: SORT OUT ERROR HANDLING
//https://www.woolha.com/tutorials/flutter-using-streamcontroller-and-streamsubscription
    task.future.asStream().listen(
      (event) {
        print('TOTAL BYTES ${event.totalByteCount}');
      },
      onDone: () {
        _success(name);
        pr.hide();
      },
      onError: (error) {},
    ); //.onDone(_success(name));
  }
}

//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_storage/example/lib/main.dart#L84
