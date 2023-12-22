import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/apis.dart';
import 'package:shopapp/providers/profile_provider.dart';
import 'package:shopapp/widget/constant.dart';

class EditScreen extends ConsumerWidget {
   const EditScreen({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
  final  about = ref.watch(aboutProvider);
  final  userData = ref.watch(userDataProvider);
final nameController  = TextEditingController(text: userData!.displayName.toString());
final addressController  = TextEditingController(text: about);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Stack(
                children: [
                    SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(userData!.photoURL.toString() ),
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey.shade300,
                         border: Border.all(color: Colors.white,width: 2)
                      ),
                      child: const Icon(Icons.image,size: 15,),
                    ),
                  )
                ],
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText:"Name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Constant.pink,width: 1),
                  )
                ),
              ),
              TextFormField(

                controller: addressController,
                decoration: InputDecoration(
                  labelText: "About",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Constant.pink,width: 1)
                    )
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.pink,
                  ),
                    onPressed: () async {
                     await Apis.updateUserName(nameController.text);
                    ref.watch(aboutProvider.notifier).state = addressController.text;
                  Navigator.pop(context);
                }, child: const Text("UPDATE PROFILE",style: TextStyle(color: Colors.white,fontSize: 18),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

