import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/video.dart';

class ProfileViewModel with ChangeNotifier {
  // BuildContext context;
  ProfileViewModel() {
    queryAll();
  }

  List<Video> _videos = [];

  List<Video> get videos {
    return _videos;
  }

  set videos(List<Video> value) {
    _videos = value;
    notifyListeners();
  }

  final dbHelper = DatabaseHelper.instance;

  queryAll() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows: $allRows');

    List<Video> newVideos = [];

    for (var row in allRows) {
      // print(row['videos_paths']);
      Map<String, dynamic> _videos = jsonDecode(row['videos_paths']);
      print("_videos $_videos");
      _videos.forEach((key, value) {
        Video video = Video()
          ..creationDate = DateTime.fromMillisecondsSinceEpoch(
              int.parse(key, onError: (error) => 0))
          ..path = value;

        newVideos.add(video);
      });
    }

    videos = newVideos;
  }
}
