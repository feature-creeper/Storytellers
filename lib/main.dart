import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storytellers/book_details.dart';

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

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int navIndex = 0;

  void setPage(int index) {
    setState(() {
      navIndex = index;
    });
  }

  Widget _page() {
    switch (navIndex) {
      case 0:
        return MyHomePage();
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Discover')),
          BottomNavigationBarItem(
              icon: Icon(Icons.book), title: Text('Bookcase')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Me')),
        ],
        currentIndex: navIndex,
        fixedColor: Colors.deepPurple,
        onTap: setPage,
      ),
      body: _page(),
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
          return BookList(goToBookDetails);
        });
  }
}

class BookList extends StatelessWidget {
  final VoidCallback goToDetails;
  const BookList(this.goToDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text("Featured",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemExtent: 110,
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: goToDetails,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          height: 105,
                          width: 90,
                          child: Image.asset(
                            "assets/images/rd_cbucket1.jpg",
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Book Title",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Author",
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
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
