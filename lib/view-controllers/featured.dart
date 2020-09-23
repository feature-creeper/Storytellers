import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:storytellers/model/book.dart';
import 'package:provider/provider.dart';
import 'package:storytellers/view-model/home_view-model.dart';

class Featured extends StatefulWidget {
  final List<String> bookIds;
  final Function goToDetails;
  final String sectionTitle;
  const Featured(this.goToDetails, this.sectionTitle, this.bookIds);

  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  Future<Book> _getBook(String id) async {
    return context.read<HomeViewModel>().getBookFromFirestore(id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(widget.sectionTitle,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemExtent: 110,
            scrollDirection: Axis.horizontal,
            itemCount: widget.bookIds.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  FutureBuilder<Book>(
                      future: _getBook(widget.bookIds[index]),
                      builder: (context, AsyncSnapshot<Book> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return _BookThumbnail(
                            goToDetails: widget.goToDetails,
                            book: snapshot.data,
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                  SizedBox(width: 15)
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _BookThumbnail extends StatefulWidget {
  const _BookThumbnail({@required this.goToDetails, this.book});

  final Function goToDetails;
  final Book book;

  @override
  __BookThumbnailState createState() => __BookThumbnailState();
}

class __BookThumbnailState extends State<_BookThumbnail> {
  String bookUrl;

  image() async {
    final StorageReference ref =
        FirebaseStorage().ref().child(widget.book.imagePath);
    String path = await ref.getDownloadURL();
    setState(() {
      bookUrl = path;
    });
  }

  @override
  void initState() {
    image();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.goToDetails(widget.book),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 105,
              width: 90,
              child: bookUrl == null
                  ? Container()
                  : Image.network(bookUrl, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        // return Center(
                        //     child: CircularProgressIndicator(
                        //   backgroundColor: Colors.grey[300],
                        //   valueColor:
                        //       AlwaysStoppedAnimation<Color>(Colors.white),
                        //   value: loadingProgress.expectedTotalBytes != null
                        //       ? loadingProgress.cumulativeBytesLoaded /
                        //           loadingProgress.expectedTotalBytes
                        //       : null,
                        // ),

                      }
                    })),
          SizedBox(height: 5),
          Text(
            widget.book.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("Author")
        ],
      ),
    );
  }
}
