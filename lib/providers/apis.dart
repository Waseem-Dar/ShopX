import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/providers/model.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static User user = auth.currentUser!;

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
    return await fireStore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  static Future<void> updateUserName(String name) async {
    await fireStore.collection("users").doc(user.uid).update({'name': name});
  }
                                                                                  // Favorites
  static Future<void> toggleFavorites(DocumentSnapshot product) async {
    final isFavorite = await fireStore
        .collection('favorites')
        .doc(product.id)
        .get()
        .then((docSnapshot) => docSnapshot.exists);

    if (!isFavorite) {
      await Apis.fireStore
          .collection('favorites')
          .doc(product.id)
          .set(product.data() as Map<String, dynamic>);
    } else {
      await Apis.fireStore.collection('favorites').doc(product.id).delete();
    }
  }
                                                                                  // cart
  static Future<void> toggleCart(DocumentSnapshot product) async {
    final isCart = await fireStore
        .collection("cart")
        .doc(product.id)
        .get()
        .then((docSnapshot) => docSnapshot.exists);
    if(isCart){
      Fluttertoast.showToast(
          msg: "Already added",
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black54,
          fontSize: 16.0
      );
    }else{
      await fireStore.collection("cart").doc(product.id).set(product.data() as Map<String ,dynamic>);
    }
  }
}
