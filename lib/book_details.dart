import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stretchy_header/stretchy_header.dart';

class BookDetails extends StatefulWidget {
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  void goHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: goHome,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: new BoxDecoration(
                  color: Colors.black.withAlpha(120),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 100,
              height: 100,
              // color: Colors.red,
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        StretchyHeader.listViewBuilder(
          headerData: HeaderData(
            blurContent: false,
            headerHeight: 250,
            header: Image.asset(
              "assets/images/rd_cbucket1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          itemCount: 1,
          itemBuilder: (context, index) {
            return _BookMainDetails();
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          // widthFactor: Size.infinite.width,
          child: Container(
            height: 100,
            width: double.infinity,
            color: Colors.blueAccent,
            child: SafeArea(
              left: false,
              top: false,
              child: FlatButton(
                onPressed: () => print("YO"),
                child: Text(
                  "Let's read!",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                color: Colors.blueAccent,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class _BookMainDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: 10),
        Text("Book title",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(
          "Author",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 20),
        Text(
          "Eleven-year-old Charlie Bucket is very poor and lives in a small house with his parents and four grandparents. One day, Grandpa Joe tells him about the legendary and eccentric chocolatier Willy Wonka and all the wonderful sweets and chocolates.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}
