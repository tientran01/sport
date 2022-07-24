import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_app/model/users.dart';
import 'package:sport_app/resource/app_collection.dart';

class FirestoreRepository {
  static FirestoreRepository shared = FirestoreRepository._internal();
  FirestoreRepository._internal();
  late CollectionReference collection;

  Future<void> addUser(User currentUser) async {
    collection = FirebaseFirestore.instance.collection(AppCollection.user);
    Users user = Users(
      displayName: currentUser.displayName,
      email: currentUser.email,
      photoUrl: currentUser.photoURL,
    );
    collection.add(user);
  }
}
