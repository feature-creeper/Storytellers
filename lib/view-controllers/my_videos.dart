import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/view-controllers/video_player.dart';

class MyVideos extends StatefulWidget {
  @override
  _MyVideosState createState() => _MyVideosState();
}

class _MyVideosState extends State<MyVideos> {
  final dbHelper = DatabaseHelper.instance;

  List<String> a = ["A", "B"];

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    setState(() {
      allRows.forEach((row) => a.add(row['name']));
    });
  }

  @override
  void initState() {
    _query();
    super.initState();
  }

  _showVideo(String path) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MyVideoPlayer(path)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[50],
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: a.length,
          itemBuilder: (context, index) {
            return FlatButton(
                onPressed: () => _showVideo(a[index]),
                child: Text("My video ${index + 1}"));
          }),
    );
  }
}
