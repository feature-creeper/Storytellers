import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storytellers/view-controllers/book_details.dart';

import 'view-controllers/featured.dart';
import 'view-controllers/navigation_bar.dart';

void main() {
  runApp(MyApp());
}

//solwayTextTheme
//heeboTextTheme

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storytellers',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.heeboTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: NavigationBar(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
}
