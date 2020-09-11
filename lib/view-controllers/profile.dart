import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/view-controllers/video_player.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: _signOut,
            child: Icon(
              Icons.exit_to_app,
              size: 35,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
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
