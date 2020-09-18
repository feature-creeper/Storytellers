class Book {
  String title;
  String author;
  String effectStoragePath;
  String id;

  Book();

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
}
