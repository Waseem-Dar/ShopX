
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/providers/model.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static   User  user = auth.currentUser!;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

// static UserModel me = fireStore.collection("users").doc(user.uid).get() as UserModel;


  static Future<bool> userExists() async {
    log("user Exits");
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final userModel = UserModel(
        name: user.displayName.toString(),
        email: user.email.toString(),
        image: user.photoURL.toString());
    log("create user");
    return await fireStore.collection("users").doc(user.uid).set(userModel.toMap());
  }


  static Future<void> updateUserName(String name)async{
     await fireStore.collection("users").doc(user.uid).update({'name':name});
  }

}












// static Future<void> deleteUserData()async{
//   log("delete user");
//   return await fireStore.collection("users").doc(user.uid).delete();
// }
// static late UserModel me;
//
//   static Future<void> getSelfInfo() async {
//     await fireStore.collection('users').doc(user.uid).get().then((user) async {
//       if (user.exists) {
//         me = UserModel.fromMap(user.data()!);
//       } else {
//         await createUser().then((value) => getSelfInfo());
//       }
//     });
//   }


// static Future<void> createAndFetchUser() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user == null) {
//     // Handle the case where the user is not signed in.
//     return;
//   }
//
//   final userDoc = await fireStore.collection('users').doc(user.uid).get();
//
//   if (userDoc.exists) {
//     // User data exists, initialize 'me'.
//     me = UserModel.fromMap(userDoc.data()!);
//   } else {
//     // User data doesn't exist, create the user data and then fetch it.
//     await createUser().then((value) {
//       getSelfInfo();
//     });
//   }
// }



// static Future<void> deleteUser(String email) async {
//   final data = await fireStore
//       .collection('users')
//       .where("email", isEqualTo: email)
//       .get();
//   await  fireStore
//       .collection("users")
//       .doc(user.uid)
//       .delete();
// }
