import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/screens/auth_screens/auth_options.dart';
import 'package:shopapp/screens/auth_screens/signin_screen.dart';
import 'package:shopapp/screens/auth_screens/signup_screen.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/screens/tab_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:badges/badges.dart';

late Size mq ;
Future<void> main() async {


WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home:  const SplashScreen(),
    );
  }
}

