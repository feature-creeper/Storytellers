import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/database/database-helper.dart';
import 'package:storytellers/model/video.dart';
import 'package:storytellers/view-controllers/video_player.dart';
import 'package:storytellers/view-model/profile_view-model.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileViewModel vm;

  List<Video> videos;

  double get screenWidth {
    return MediaQuery.of(context).size.width;
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
  void initState() {
    vm = context.read<ProfileViewModel>();
    // screenWidth = MediaQuery.of(context).size.width;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    videos =
        context.select<ProfileViewModel, List<Video>>((value) => value.videos);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // FlatButton(
          //   onPressed: vm.queryAll,
          //   child: Icon(
          //     Icons.phone_iphone,
          //     size: 35,
          //   ),
          // ),
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
      body: ListView(
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CircleAvatar(
            radius: 60,
          ),
          SizedBox(height: 15),
          Text(
            'Username',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
            child: Text('My Videos',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
                children: videos
                    .map((e) => GestureDetector(
                        onTap: () => _showVideo(e.path),
                        child: _VideoCell(e, screenWidth)))
                    .toList()),
          ),
        ],
      ),
    );
  }
}

class _VideoCell extends StatelessWidget {
  final Video video;
  final double screenWidth;
  const _VideoCell(this.video, this.screenWidth);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (screenWidth / 4) - 5,
      child: AspectRatio(
        aspectRatio: 0.6,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(9)),
        ),
      ),
      // height: 100,
    );
  }
}
