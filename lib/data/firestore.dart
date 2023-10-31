/*

This database Stores post that users have published in the app
It is stored in a collection called 'posts in firebase

each postpost contains:
- a message
- email of user 
_ thimestamp
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FiresstoreDatabase {
  //current login user
  User? user = FirebaseAuth.instance.currentUser;

  //get collection of posts
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post messsage

  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'timestamp': Timestamp.now(),
    });
  }

  //read post

  Stream<QuerySnapshot> getPostStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy(
          'timestamp',
          descending: true,
        )
        .snapshots();

    return postsStream;
  }
}
