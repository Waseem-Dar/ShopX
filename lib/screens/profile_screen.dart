import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/profile_provider.dart';
import 'package:shopapp/screens/profile_edit_screen.dart';
import '../main.dart';
import '../widget/drawer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String about = ref.read(aboutProvider);
    String animationName = ref.watch(animationProvider);
    final userdata = ref.watch(userDataProvider);
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: mq.height * .7,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(userdata.photoURL.toString()),
                  fit: BoxFit.cover)),
        ),
        Container(
          width: double.infinity,
          height: mq.height * .7,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.purple.withOpacity(0.5),
                  Colors.teal.shade800,
                ]),
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              width: double.infinity,
              height: mq.height * .6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 150,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              animationName.toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                  color: Colors.white),
                            ),
                            Text(
                              about,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.person_2_outlined),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            Text(userdata.displayName.toString()),
                          ],
                        ),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.email_outlined),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                            Text(userdata.email.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 30,
          top: mq.height * .5,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(userdata.photoURL.toString()),
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(75)),
          ),
        ),
      ],
    ));
  }
}
