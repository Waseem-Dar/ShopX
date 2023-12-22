import 'package:flutter/material.dart';
import 'package:shopapp/widget/constant.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int isNotification = 2;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon:const Icon(Icons.more_vert_outlined))
        ],
        iconTheme:const IconThemeData(color: Colors.white),
        backgroundColor: Constant.pink,
        title:  const Text("Notifications",style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body:isNotification==1? Center(
        child: SizedBox(
          width: 250,
          // height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/noti.png"),
              const SizedBox(height: 15,),
              const Text(
                "No Notifications Yet",
                style:
                TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5,),
              const Text(
                "You have no notifications right now.Come back later",
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ): ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            // color: Colors.black26,
            padding: const EdgeInsets.symmetric(horizontal: 10,),
            child: Card(
              elevation: 5,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              child: Container(
                // color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Constant.pink,
                              borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset("assets/images/x.png"),
                        ),
                        const SizedBox(width: 10,),
                        const Text(
                          "Shop Center",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),

                        const Expanded(child: SizedBox()),
                        const Text("25m ago",style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const Text("A notification is a message that Android displays outside your app's UI to provide the user with reminders"),
                  ],
                ),
              ),),
          );
        },),
    );
  }
}
