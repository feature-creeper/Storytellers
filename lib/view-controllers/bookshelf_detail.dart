import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-model/bookshelf_details_view-model.dart';

class BookShelfDetail extends StatefulWidget {
  @override
  _BookShelfDetailState createState() => _BookShelfDetailState();
}

class _BookShelfDetailState extends State<BookShelfDetail> {
  _launchLive() {
    context.read<BookshelfDetailsViewModel>().launchDeepAR();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(children: [
          FlatButton(
              onPressed: _checkEffect, child: Text("CHECK EFFECT Location")),
          SizedBox(height: 50),
          FlatButton(onPressed: _launchLive, child: Text("Launch LIVE")),
        ]),
      ),
    );
  }
}
