import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-controllers/bookshelf_detail.dart';
import 'package:storytellers/view-model/bookshelf_details_view-model.dart';
import 'package:storytellers/view-model/my_books_view-model.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';

class MyBooks extends StatefulWidget {
  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  List<Book> myBooks = [];

  _goToBookDetail(int index) {
    Widget provider = ChangeNotifierProvider(
      create: (_) => BookshelfDetailsViewModel(myBooks[index], context),
      builder: (_, __) => BookShelfDetail(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => provider),
    );
  }

  @override
  Widget build(BuildContext context) {
    myBooks = context.watch<SavedBooksProvider>().myBooks;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: myBooks.length + 1,
          itemBuilder: (_, index) {
            if (index == 0) {
              return Container(
                padding: EdgeInsets.all(25),
                child: Text("My Books",
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              );
            } else {
              return _MyBookTile(() => _goToBookDetail(index - 1),
                  book: myBooks[index - 1]);
            }
          }),
    );
  }
}

class _MyBookTile extends StatelessWidget {
  const _MyBookTile(
    this._goToBookDetail, {
    @required this.book,
  });
  final Function _goToBookDetail;
  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToBookDetail(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            margin: EdgeInsets.all(15),
            width: 70,
            height: 85,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(book.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Text(book.author, style: TextStyle(fontSize: 18))
            ],
          ),
        ],
      ),
    );
    // return ListTile(
    //   onTap: () => _goToBookDetail(),
    //   leading: Icon(Icons.account_circle),
    //   title: Text(book.title),
    //   subtitle: Text(book.author),
    // );
  }
}
