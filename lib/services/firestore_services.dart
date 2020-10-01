import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storytellers/model/book.dart';

class FirestoreServices {
//Client client
//FirestoreServices(Client)

  // Future<List<Book>> getFeatured(CollectionReference ref) async {
  //   //List<String> _bookIds = [];
  //   QuerySnapshot snapshot = await ref.get();

  //   snapshot.docs.forEach((document) {
  //     String id = document.data()['id'];
  //     if (id != null) {
  //       String newId = id;
  //       //_bookIds.add(newId);
  //       //Get Book with id
  //     }
  //   });
  //   return List<Book>();
  // }

//Temp for testing
  Future<List<String>> getFeatured(String collectionName) async {
    CollectionReference ref =
        FirebaseFirestore.instance.collection(collectionName);
    List<String> _bookIds = [];
    QuerySnapshot snapshot = await ref.get();

    snapshot.docs.forEach((document) {
      String id = document.data()['id'];
      if (id != null) {
        String newId = id;
        _bookIds.add(newId);
        //Get Book with id
      }
    });
    return _bookIds;
  }
}
