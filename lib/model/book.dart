import 'dart:convert';

class Book {
  String title;
  String author;
  String effectStoragePath;
  String id;
  int dbRowId;
  // List<String> _videoPaths = [];
  Map<String, dynamic> videoPaths;

  Book();

  // List<String> get videoPaths {
  //   return _videoPaths;
  // }

  // setVideoPaths(String value) {
  //   _videoPaths = value.split('|');
  //   print('_videoPaths $_videoPaths');
  // }

  Book.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        effectStoragePath = json['effect'] ?? "" {
    print("title of book $title");
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
      };

  // String stringifyVideoPaths() {
  //   String paths = '';
  //   for (var item in videoPaths) {
  //     paths += item + '|';
  //   }
  //   return paths;
  // }
}
