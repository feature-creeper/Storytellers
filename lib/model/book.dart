import 'dart:convert';

class Book {
  String title;
  String author;
  String effectStoragePath;
  String id;
  int dbRowId;
  String imagePath;
  Map<String, dynamic> videoPaths;

  Book();

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        imagePath = json['cover'] ?? "",
        effectStoragePath = json['effect'] ?? "" {
    print("title of book $title");
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
      };
}
