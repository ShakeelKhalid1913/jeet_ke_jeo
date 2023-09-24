import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserCollection {
  late FirebaseFirestore firestore;
  late CollectionReference usersCollection;

  FirebaseUserCollection() {
    firestore = FirebaseFirestore.instance;
    usersCollection = firestore.collection('users');
  }

  void addUser(Map<String, dynamic> data) async {
    await usersCollection.doc(data['uid']).set(data);
  }
}
