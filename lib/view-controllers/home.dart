import 'package:flutter/material.dart';
import 'book_details.dart';
import 'featured.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AutomaticKeepAliveClientMixin {
  void goToBookDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetails()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 80, 0, 30),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Featured(goToBookDetails);
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
