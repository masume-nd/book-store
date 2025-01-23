// import '../models/book.dart';
// import 'package:hive/hive.dart';

// class BookAdapter extends TypeAdapter<Book> {
//   @override
//   final int typeId = 0; // Unique identifier for the Book class

//   @override
//   Book read(BinaryReader reader) {
//     // Deserialize the Book object from binary
//     final title = reader.readString();
//     final author = reader.readString();
//     final description = reader.readString();
//     final imageUrl = reader.readString();
//     final id = reader.readString();
//     final price = reader.readDouble();
//     final user = reader.read();
    
//     return Book(title, author, description, imageUrl, id, price, user);
//   }

//   @override
//   void write(BinaryWriter writer, Book obj) {
//     // Serialize the Book object to binary
//     writer.writeString(obj.title);
//     writer.writeString(obj.author);
//     writer.writeString(obj.description);
//     writer.writeString(obj.imageUrl);
//     writer.writeString(obj.id);
//     writer.writeDouble(obj.price);
//     writer.write(obj.user);
//   }
// }
