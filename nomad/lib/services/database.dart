import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addUserInfoToDB(String userID, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserFromDB(String userID) async {
    return FirebaseFirestore.instance.collection('users').doc(userID).get();
  }
  // collection references:

  // final CollectionReference userCollection =
  //     FirebaseFirestore.instance.collection('users');
}
