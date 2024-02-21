import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopapp/providers/apis.dart';
import 'package:shopapp/providers/profile_provider.dart';
import 'package:shopapp/screens/Notification_screen.dart';
import 'package:shopapp/screens/auth_screens/auth_options.dart';
import 'package:shopapp/screens/favorite_screen.dart';
import 'package:shopapp/widget/constant.dart';


class ShowDrawer extends ConsumerWidget {
  const ShowDrawer({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userData = ref.watch(userDataProvider);
    return SafeArea(
      child: Drawer(
        child: ListView(children: [
          DrawerHeader(

            decoration: BoxDecoration(color: Constant.pink), child:  Column(
              children: [
                 CircleAvatar(
                  maxRadius: 50,
                    backgroundImage: NetworkImage(userData.photoURL.toString()),
                   ),
                Text(userData.displayName.toString(),style: const TextStyle(color: Colors.white,fontSize: 22),)
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              },
            iconColor:  Constant.pink,
            leading: Icon(Icons.home,),
            title: const Text("Home"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
           ListTile(
             onTap: () {
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteScreen(),));
             },
             iconColor:  Constant.pink,
            leading: Icon(Icons.favorite),
            title: const Text("Favorite"),
             trailing: Icon(Icons.keyboard_arrow_right_rounded),
           ),
           ListTile(
             onTap: () {
               Navigator.pop(context);
               Navigator.push(context, MaterialPageRoute(builder: (context) =>const NotificationScreen(),));
             },
             iconColor:  Constant.pink,
            leading: Icon(Icons.notifications,),
            title: const Text("Notification"),
             trailing: Icon(Icons.keyboard_arrow_right_rounded),
           ),
           ListTile(
             iconColor:  Constant.pink,
            leading: Icon(Icons.settings,),
            title: const Text("Setting"),
             trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),
          ListTile(
            onTap: () async {
              // await Apis.deleteUserData();
              await FirebaseAuth.instance.signOut().then((value) async {
                await GoogleSignIn().signOut().then((value) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Apis.auth  = FirebaseAuth.instance ;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthScreen(),
                      ));
                });
              });

            },
            iconColor: Constant.pink,
            leading: Icon(Icons.logout_sharp),
            title: const Text("Log out"),
            trailing: Icon(Icons.keyboard_arrow_right_rounded),
          ),

        ]
      ),
      ),
    );
  }
}

AlertDialog logOutDialog(BuildContext context){
  return AlertDialog(

  );
}