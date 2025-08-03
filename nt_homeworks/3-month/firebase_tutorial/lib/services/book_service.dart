import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookService {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  CollectionReference get bookCollectionReference =>
      firebaseFirestore.collection("users").doc(userUid).collection("books");

  // add book
  Future<void> addBook({
    required String title,
    required String author,
    required int pages,
    required String status,
  }) async {
    log("addd");
    final DocumentReference documentSnapshot = await bookCollectionReference
        .add({
          "title": title,
          "author": author,
          "pages": pages,
          "status": status,
          "created_at": Timestamp.now(),
        });

    log(documentSnapshot.toString());
  }

  // get books
  Stream<QuerySnapshot> getBooks() {
    return bookCollectionReference
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  Future<void> updateBook(String uid, String status) async {
    await bookCollectionReference.doc(uid).update({"status": status});
  }
  

  // DELETE
  Future<void> deleteBook(String uid) async {
    await bookCollectionReference.doc(uid).delete();
  }
}
