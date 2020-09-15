import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:storytellers/model/book.dart';

class HomeViewModel with ChangeNotifier {
  CollectionReference _featuredCollection =
      FirebaseFirestore.instance.collection('featured');
  CollectionReference _recentlyAddedCollection =
      FirebaseFirestore.instance.collection('recently_added');

  List<String> _featuredBookIds = [];
  List<String> _recentlyAddedBookIds = [];

  List<String> get featured {
    return _featuredBookIds;
  }

  set featured(List<String> books) {
    _featuredBookIds = books;
    notifyListeners();
  }

  List<String> get recentlyAdded {
    return _recentlyAddedBookIds;
  }

  set recentlyAdded(List<String> books) {
    _recentlyAddedBookIds = books;
    notifyListeners();
  }

  HomeViewModel() {
    _getBooks();
  }

  _getBooks() async {
    featured = await fetchFeaturedBooks(_featuredCollection);
    recentlyAdded = await fetchFeaturedBooks(_recentlyAddedCollection);
  }

  Future<List<String>> fetchFeaturedBooks(CollectionReference list) async {
    List<String> _bookIds = [];
    QuerySnapshot snapshot = await list.get();

    snapshot.docs.forEach((document) {
      String id = document.data()['id'];
      if (id != null) {
        String newId = id;
        _bookIds.add(newId);
      }
    });
    return _bookIds;
  }

  Future<Book> getBookFromFirestore(String id) async {
    CollectionReference books = FirebaseFirestore.instance.collection('books');
    DocumentSnapshot snapshot = await books.doc(id).get();
    return Book.fromJson(snapshot.data());
  }

  fromJson(Map<String, dynamic> json) {}
}
