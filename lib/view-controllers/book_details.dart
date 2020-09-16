import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-controllers/role_select.dart';
import 'package:storytellers/view-model/book_details_view-model.dart';
import 'package:storytellers/view-model/role_select_view-model.dart';
import 'package:stretchy_header/stretchy_header.dart';

class BookDetails extends StatefulWidget {
  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  BookDetailsViewModel vm;

  void goHome() {
    Navigator.pop(context);
  }

  void _addToMyBooks() {
    vm.tappedAddToMyBooks();
  }

  void goToRoleSelect() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (_) => RoleSelectViewModel(),
            builder: (context, child) => RoleSelect()),
      ),
    );
  }

  @override
  void initState() {
    vm = context.read<BookDetailsViewModel>();
    super.initState();
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
            return _BookMainDetails(vm.book);
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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: _addToMyBooks,
                child: Text(
                  "Add to bookshelf",
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
  final Book book;
  _BookMainDetails(this.book);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: 10),
        Text(book.title,
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
        // SizedBox(height: 5),
        Text(
          book.author,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 14),
        Row(
          children: [
            Text(
              "For ages  ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              "8+",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Text(
              "Read time  ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              "100 mins",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        SizedBox(height: 30),
        Text(
          "Eleven-year-old Charlie Bucket is very poor and lives in a small house with his parents and four grandparents. One day, Grandpa Joe tells him about the legendary and eccentric chocolatier Willy Wonka and all the wonderful sweets and chocolates.",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}
