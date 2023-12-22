import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widget/constant.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({super.key});
final emailController = TextEditingController();
final passwordController = TextEditingController();
void userSignIn(){
  String email = emailController.text;
  String password = passwordController.text;
  if(email == "" && password == ""){
  Constant.showToast("please fil all fields");

  }else{}
}
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40,),
                  width: double.infinity,
                  height: mq.height * .3,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                      Text(
                        "Sign in!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 60,bottom: 20),
                  height: mq.height * .7,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        TextFormField(
                          controller: emailController,
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                            labelText:'Gmail',
                            labelStyle: TextStyle(
                              color: Constant.pink,
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Constant.pink),
                            ),
                            suffixIcon: IconButton(onPressed:(){} , icon: const Icon(Icons.check))
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordController,
                          decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                              labelText:'Password',
                              labelStyle: TextStyle(
                                color: Constant.pink,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Constant.pink),
                              ),
                              suffixIcon: IconButton(onPressed:(){} , icon: const Icon(Icons.remove_red_eye_outlined))
                          ),
                        ),
                          const SizedBox(height: 20,),
                        const Text("Forgot password?",style: TextStyle(fontSize: 18),)
                      ],),
                      InkWell(
                        onTap: () => userSignIn(),
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(colors: [ Constant.pink,
                              Colors.black.withOpacity(0.9),])
                          ),
                          child: const Center(child: Text("SIGN IN",style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),)),
                        ),
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        Text("Don't have account?"),
                        Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ],)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
