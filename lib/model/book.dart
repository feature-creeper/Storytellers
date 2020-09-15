import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String title;
  String id;

  Book();

  Book.fromJson(Map<String, dynamic> json) : title = json['title'] {
    print("title of book $title");
  }
}
