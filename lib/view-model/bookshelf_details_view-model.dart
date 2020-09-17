import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/book.dart';
import 'package:path_provider/path_provider.dart';

class BookshelfDetailsViewModel with ChangeNotifier {
  static const MethodChannel nativeCallChannel =
      const MethodChannel('com.storytellers.storytellers/nativecall');

  final dbHelper = DatabaseHelper.instance;

  launchDeepAR() async {
    String info;
    try {
      info = await nativeCallChannel
          .invokeMethod("pushPop", {"text": "Some random text"});
      //_updateDB(info);
    } on PlatformException {
      info = "Failed to push native view.";
    }
  }

  // void _updateDB(String path) async {
  //   // row to update
  //   Map<String, dynamic> row = {
  //     DatabaseHelper.columnId: 1,
  //     DatabaseHelper.columnName: path,
  //     DatabaseHelper.columnAge: 32
  //   };
  //   final rowsAffected = await dbHelper.update(row);
  //   if (rowsAffected == 0) {
  //     final id = await dbHelper.insert(row);
  //     print('inserted row id: $id');
  //   }
  //   print('updated $rowsAffected row(s)');
  // }
}
