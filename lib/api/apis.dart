import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat_app/models/chatUser.dart';

class APIs {
  //for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  //for checking user exists or not
  static Future<bool> userExists() async {
    return (await firestore.collection("users").doc(user.uid).get()).exists;
  }

  //for creating new users
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using We Chat!",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }
  // static Future<void> createUser() async {
  //   final time = DateTime.now().microsecondsSinceEpoch.toString();
  //   final chatUser = ChatUser(
  //       image: user.photoURL ?? "",
  //       about: "Hey, I am using We Chat",
  //       name: user.displayName ?? "",
  //       createdAt: time,
  //       id: user.uid,
  //       lastActive: time,
  //       isOnline: false,
  //       pushToken: "",
  //       email: user.email ?? "");
  //   return await firestore
  //           .collection("users")
  //           .doc(user.uid)
  //           .set(chatUser.toJson());
  // }
}
