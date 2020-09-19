import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-model/bookshelf_details_view-model.dart';

class BookShelfDetail extends StatefulWidget {
  @override
  _BookShelfDetailState createState() => _BookShelfDetailState();
}

class _BookShelfDetailState extends State<BookShelfDetail> {
  Book book;

  _launchLive() {
    context
        .read<BookshelfDetailsViewModel>()
        .launchDeepAR(book.effectStoragePath);
  }

  _checkEffect() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/myEffect';

    print(dir.list().forEach((element) async {
      print(element.path);
      FileStat stat = await element.stat();
      print(stat.size);
    }));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    book =
        context.select<BookshelfDetailsViewModel, Book>((value) => value.book);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        // bottomOpacity: 0,
        // toolbarOpacity: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Spacer(),
                Container(
                  //constraints: BoxConstraints.,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  width: 120,
                  height: 150,
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 15),
            Text(book.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text(book.author,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            // FlatButton(
            //     onPressed: _checkEffect, child: Text("CHECK EFFECT Location")),

            Padding(
              padding: const EdgeInsets.fromLTRB(35, 27, 35, 35),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: EdgeInsets.all(15),
                onPressed: _launchLive,
                child: Text(
                  "Let's read!",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
                color: Colors.blueAccent,
              ),
            ),
            Text("Videos",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
