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
    final userDoc = usersCollection.doc(data['uid']);
    var items = await userDoc
        .get()
        .then((snapshot) => snapshot.get('lotteryPurchased'));

    if (items == null) {
      items = [];

      await userDoc.update({'lotteryPurchased': items});
    }

    items.add(data['lotteryPurchased'][0]);
    items = items.toSet().toList();
    data['lotteryPurchased'] = [...items];

    await userDoc.set(data);
  }

  Future<bool> isUserExist(String uid) async{
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();
    return documentSnapshot.exists;
  }

  Future<UserModel> getUser(String uid) async {
    DocumentSnapshot documentSnapshot = await usersCollection.doc(uid).get();
    return UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);
  }
}
