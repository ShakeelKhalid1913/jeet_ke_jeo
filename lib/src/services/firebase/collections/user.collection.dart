import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jeet_ke_jeo/src/models/lottery.model.dart';
import 'package:jeet_ke_jeo/src/models/user.model.dart';

class FirebaseUserCollection {
  late FirebaseFirestore firestore;
  late CollectionReference usersCollection;

  FirebaseUserCollection() {
    firestore = FirebaseFirestore.instance;
    usersCollection = firestore.collection('users');
  }

  void addUser(Map<String, dynamic> data) async {
    if (!(await isUserExists(data['uid']))) {
      await usersCollection.doc(data['uid']).set({
        'uid': data['uid'],
        'username': data['username'],
        'address': data['address'],
        'phone': data['phone'],
        'lotteryPurchased': [],
      });
    }

    final userDoc = usersCollection.doc(data['uid']);

    var items = await userDoc
        .get()
        .then((snapshot) => snapshot.get('lotteryPurchased'));

    items.add(data['lotteryPurchased'][0].toJson());
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
    //get lottery purchased from data
    List<Lottery> lotteryPurchased = [];
    List<dynamic> lotteryPurchasedData =
        documentSnapshot.get('lotteryPurchased');
    for (var element in lotteryPurchasedData) {
      lotteryPurchased.add(Lottery.fromJson(element));
    }
    //add lottery purchased to data
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    data['lotteryPurchased'] = lotteryPurchased;

    return UserModel.fromJson(data);
  }

  Future<int> getNumberOfUsers() async {
    AggregateQuerySnapshot query = await usersCollection.count().get();
    return query.count;
  }
}
