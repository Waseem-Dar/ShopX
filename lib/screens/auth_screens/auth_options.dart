import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/all_provider.dart';
import 'package:shopapp/providers/apis.dart';
import 'package:shopapp/screens/auth_screens/signin_screen.dart';
import 'package:shopapp/screens/auth_screens/signup_screen.dart';
import 'package:shopapp/screens/tab_screen.dart';
import 'package:shopapp/widget/constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../providers/profile_provider.dart';

class AuthScreen extends ConsumerWidget {
   const AuthScreen({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {

    void refreshProvider(){
      ref.refresh(productsStreamProvider);
      ref.refresh(favoriteStreamProvider);
      ref.refresh(cartStreamProvider);
      ref.refresh(userDataProvider);
    }

    Future<UserCredential> signInWithGoogle() async {

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {

        log("GOOGLE USER NAME ${Apis.user.displayName}");
        log("GOOGLE USER NAME ${Apis.user.email}");
      }

      return userCredential;
    }

    void clickGoogleButton() {

      signInWithGoogle().then((user) async {

        if ((await Apis.userExists())) {
          log("user Exits");
          refreshProvider();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TabScreen(),
            ),
          );
        } else {
          Constant.showProgressBar(context,Colors.white);
            log("create user");
          Apis.createUser().then((value)async {
             await Apis.addProductsToFireStore().then((value){
               refreshProvider();
               Navigator.pop(context);
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                   builder: (context) => const TabScreen(),
                 ),
               );
             });

          });
        }
      }).catchError((error) {
        log('Error during sign-in: $error');
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Constant.pink,
              Colors.black.withOpacity(0.9),
            ])
                // colors: [Constant.pink,Colors.indigo.shade900.withOpacity(0.7),])
                ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 60,
                    ),
                    Row(
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
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          )),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: const Center(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          )),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          // border: Border.all(color: Colors.white,width: 1)
                        ),
                        child: const Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Login with Social Media",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: mediaIcon(
                            "assets/images/in.png",
                          ),
                        ),
                        InkWell(
                            onTap: () {},
                            child: const SizedBox(
                              width: 10,
                            )),
                        mediaIcon(
                          "assets/images/tw.png",
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {
                              log("click");
                              clickGoogleButton();
                            },
                            child: mediaIcon(
                              "assets/images/go.png",
                            ))
                      ],
                    )
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Widget mediaIcon(String image) {
  return Image.asset(
    image,
    height: 35,
    color: Colors.white,
  );
}
