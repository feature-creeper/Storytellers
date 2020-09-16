import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MyBooksDetail extends StatefulWidget {
  @override
  _MyBooksDetailState createState() => _MyBooksDetailState();
}

class _MyBooksDetailState extends State<MyBooksDetail> {
  _launchLive() {}

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
      body: SafeArea(
        child: Container(
          child:
              FlatButton(onPressed: _checkEffect, child: Text("CHECK EFFECT")),
        ),
      ),
    );
  }
}
