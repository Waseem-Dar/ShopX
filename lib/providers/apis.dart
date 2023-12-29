import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/providers/model.dart';
import 'package:shopapp/widget/constant.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static  User get user => auth.currentUser! ;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<bool> userExists() async {
    return (await fireStore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    final userModel = UserModel(
        name: user.displayName.toString(),
        email: user.email.toString(),
        image: user.photoURL.toString());

    return await fireStore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  // static Future<void> updateUserName(String name) async {
  //   await fireStore.collection("users").doc(user.uid).update({'name': name});
  // }
                                                                                  // Favorites
  static Future<void> toggleFavorites(DocumentSnapshot product) async {

    final isFavorite = await fireStore
        .collection('allProducts').doc(user.uid).collection("favorites")
        .doc(product.id)
        .get()
        .then((docSnapshot) => docSnapshot.exists);

    if (!isFavorite) {
      await Apis.fireStore
          .collection('allProducts').doc(user.uid).collection("favorites")
          .doc(product.id)
          .set(product.data() as Map<String, dynamic>);
    } else {
      await Apis.fireStore.collection('allProducts').doc(user.uid).collection("favorites").doc(product.id).delete();
    }
  }
                                                                                  // cart
  static Future<void> toggleCart(DocumentSnapshot product) async {

    final isCart = await fireStore
        .collection("allProducts").doc(user.uid).collection("cart")
        .doc(product.id)
        .get()
        .then((docSnapshot) => docSnapshot.exists);
    if(isCart){
      Constant.showToast("Already added");
    }else{
      await fireStore.collection("allProducts").doc(user.uid).collection("cart").doc(product.id).set(product.data() as Map<String ,dynamic>);
    }
  }

  static Future<void> addProductsToFireStore() async {
    final String apiUrl = 'https://fakestoreapi.com/products';
    final CollectionReference productsRef = fireStore.collection('allProducts');

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      for (var product in data) {
        try {

          final existingProduct = await productsRef.doc(user.uid).collection("products").doc(product['id'].toString()).get();

          if (!existingProduct.exists) {
            await productsRef.doc(user.uid).collection("products").doc(product['id'].toString()).set(product);
          }
        } catch (e) {
          print('Failed to add product: $e');
        }
      }
    } else {
      print('Failed to fetch products');
    }
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getProduct() {

    return fireStore
        .collection('allProducts')
        .doc(user.uid)
        .collection('products')
        .snapshots();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getFavorite() {

    return fireStore
        .collection('allProducts')
        .doc(user.uid)
        .collection('favorites')
        .snapshots();
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getCart() {

    return fireStore
        .collection('allProducts')
        .doc(user.uid)
        .collection('cart')
        .snapshots();
  }




}
