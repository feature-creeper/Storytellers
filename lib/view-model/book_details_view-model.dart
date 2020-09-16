import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:storytellers/model/book.dart';
import 'package:path_provider/path_provider.dart';

class BookDetailsViewModel with ChangeNotifier {
  final Book book;
  BookDetailsViewModel(this.book);

  void tappedAddToMyBooks() {
    final StorageReference ref =
        FirebaseStorage().ref().child(book.effectStoragePath);
    _downloadFile(ref);
  }

  Future<void> _downloadFile(StorageReference ref) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/myEffect';

    final StorageFileDownloadTask task = ref.writeToFile(File(path));

    task.future.asStream().listen((event) {
      print('TOTAL BYTES ${event.totalByteCount}');
    }, onDone: () => print('DONE'));
  }
}

//https://github.com/FirebaseExtended/flutterfire/blob/master/packages/firebase_storage/example/lib/main.dart#L84
/*
Future<void> _downloadFile(StorageReference ref) async {
    final String url = await ref.getDownloadURL();
    final String uuid = Uuid().v1();
    final http.Response downloadData = await http.get(url);
    final Directory systemTempDir = Directory.systemTemp;
    final File tempFile = File('${systemTempDir.path}/tmp$uuid.txt');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    assert(await tempFile.readAsString() == "");
    final StorageFileDownloadTask task = ref.writeToFile(tempFile);
    final int byteCount = (await task.future).totalByteCount;
    final String tempFileContents = await tempFile.readAsString();
    assert(tempFileContents == kTestString);
    assert(byteCount == kTestString.length);

    final String fileContents = downloadData.body;
    final String name = await ref.getName();
    final String bucket = await ref.getBucket();
    final String path = await ref.getPath();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Success!\n Downloaded $name \n from url: $url @ bucket: $bucket\n '
        'at path: $path \n\nFile contents: "$fileContents" \n'
        'Wrote "$tempFileContents" to tmp.txt',
        style: const TextStyle(color: Color.fromARGB(255, 0, 155, 0)),
      ),
    ));
  }
  */
