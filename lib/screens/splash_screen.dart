import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/screens/auth_screens/auth_options.dart';
import 'package:shopapp/screens/tab_screen.dart';
import 'package:shopapp/widget/constant.dart';
import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(microseconds: 100), () async {
      setState(() {
        isAnimate = true;
      });
      Timer(const Duration(seconds: 3), () {
        if (FirebaseAuth.instance.currentUser != null) {

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const TabScreen(),
              ));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ));
        }
      });
    });
  }

  bool isAnimate = false;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constant.pink,
      body: Stack(
        children: [
          AnimatedPositioned(
              right: isAnimate ? mq.width * .25 : mq.width * -.70,
              top: mq.height * .25,
              width: mq.width * .50,
              duration: const Duration(seconds: 2),
              child: Image.asset("assets/images/logo.png")),
          AnimatedPositioned(
              left: isAnimate ? mq.width * .25 : mq.width * -.70,
              top: mq.height * .60,
              width: mq.width * .50,
              duration: const Duration(seconds: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Shop",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontFamily: "logo",
                        letterSpacing: 2),
                  ),
                  Image.asset(
                    "assets/images/x.png",
                    width: 35,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
