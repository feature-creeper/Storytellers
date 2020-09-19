import 'package:flutter/material.dart';
import 'package:storytellers/model/book.dart';
import 'package:storytellers/view-model/book_details_view-model.dart';
import 'package:storytellers/view-model/home_view-model.dart';
import 'package:storytellers/view-model/saved_books_provider.dart';
import 'book_details.dart';
import 'featured.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<Void> _getBooks;

  HomeViewModel provider;

  void goToBookDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<BookDetailsViewModel>(
              create: (_) => BookDetailsViewModel(book, context),
              builder: (_, __) => BookDetails())

          // (context) => ChangeNotifierProxyProvider<SavedBooksProvider,
          //         BookDetailsViewModel>(
          //       //create: (context) => BookDetailsViewModel(book),
          //       update: (context, value,
          //           bookDetails) => BookDetailsViewModel(book, context),
          //       child: BookDetails(),
          //     )

          // ChangeNotifierProvider(
          //   create: (_) => BookDetailsViewModel(book),
          //   child: BookDetails(),
          // ),
          ),
    );
  }

  @override
  void initState() {
    provider = context.read<HomeViewModel>();
    super.initState();
  }

  // _getBooks() {
  //   context.read<HomeViewModel>().getBooksF();
  // }

  @override
  Widget build(BuildContext context) {
    // return SafeArea(
    //     child: FlatButton(onPressed: _getBooks, child: Text("data")));
    return Scaffold(
      appBar: AppBar(
        title: Text("Storytellers"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Selector<HomeViewModel, List<String>>(
              selector: (_, model) => model.featured,
              builder: (_, bookIds, __) {
                return Featured(goToBookDetails, "Featured", bookIds);
              }),
          Selector<HomeViewModel, List<String>>(
              selector: (_, model) => model.recentlyAdded,
              builder: (_, bookIds, __) {
                return Featured(goToBookDetails, "Recently added", bookIds);
              }),
          // context.select((HomeViewModel model) => model.featured).isEmpty
          //     ? _LoadingFeaturedList()
          //     : Featured(goToBookDetails, "Featured"),
          // context.select((HomeViewModel model) => model.recentlyAdded).isEmpty
          //     ? _LoadingFeaturedList()
          //     : Featured(goToBookDetails, "Recently added"),
        ],
      ),
    );
    // return ListView.builder(
    //     padding: EdgeInsets.fromLTRB(0, 80, 0, 30),
    //     itemCount: 8,
    //     itemBuilder: (context, index) {
    //       return Featured(goToBookDetails);
    //     });
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}

class _LoadingFeaturedList extends StatelessWidget {
  const _LoadingFeaturedList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
      height: 100,
    );
  }
}
