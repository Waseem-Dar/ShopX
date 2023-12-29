import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/apis.dart';
import 'package:shopapp/screens/auth_screens/signin_screen.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


// Future<void> addProductsToFirestore() async {
//   final String apiUrl = 'https://fakestoreapi.com/products';
//   final CollectionReference productsRef = FirebaseFirestore.instance.collection('products');
//
//   final response = await http.get(Uri.parse(apiUrl));
//
//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//
//     for (var product in data) {
//       try {
//         final existingProduct = await productsRef.doc(product['id'].toString()).get();
//
//         if (!existingProduct.exists) {
//           await productsRef.doc(product['id'].toString()).set(product);
//         }
//       } catch (e) {
//         print('Failed to add product: $e');
//       }
//     }
//   } else {
//     print('Failed to fetch products');
//   }
// }
late Size mq ;
Future<void> main() async {


WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async{
  await Apis.addProductsToFireStore();
  });
  runApp(const ProviderScope(
      child: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:   SplashScreen(),
    );
  }
}

