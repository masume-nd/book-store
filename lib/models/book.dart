class Book {
  final String title;
  final String author;
  final String description;
  final String imageUrl;
  final String id;
  final double price;
  final dynamic user;

  Book(this.title, this.author, this.description, this.imageUrl, this.id,
      this.price, this.user);
}

// class Book {
//   final String title;
//   final String author;
//   final String description;
//   final String imageUrl;
//   final String id;
//   final double price;
//   final dynamic user;

//   Book({
//     required this.title,
//     required this.author,
//     required this.description,
//     required this.imageUrl,
//     required this.id,
//     required this.price,
//     this.user,
//   });
// }