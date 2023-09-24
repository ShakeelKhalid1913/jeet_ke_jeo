import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeet_ke_jeo/src/models/user.model.dart';

class FirebaseUserCollection {
  late FirebaseFirestore firestore;
  late CollectionReference usersCollection;

  FirebaseUserCollection() {
    firestore = FirebaseFirestore.instance;
    usersCollection = firestore.collection('users');
  }

  void addUser(Map<String, dynamic> data) async {
    if(!(await isUserExists(data['uid']))) {
      await usersCollection.doc(data['uid']).set(data);
      return;
    }

    final userDoc = usersCollection.doc(data['uid']);

    var items = await userDoc
        .get()
        .then((snapshot) => snapshot.get('lotteryPurchased'));

    items.add(data['lotteryPurchased'][0]);
    items = items.toSet().toList();
    data['lotteryPurchased'] = [...items];

    await userDoc.set(data);
  }

  Future<bool> isUserExists(String uid) async {
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();
    return documentSnapshot.exists;
  }

  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();
    if (!documentSnapshot.exists) {
      return null;
    }
    return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }
}
