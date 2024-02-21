import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/screens/Notification_screen.dart';
import 'package:shopapp/screens/details_screen.dart';
import 'package:shopapp/screens/home_screen.dart';
import 'package:shopapp/widget/drawer.dart';

import '../providers/apis.dart';
import '../providers/all_provider.dart';
import '../widget/constant.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  items = ref.watch(favoriteStreamProvider);

    return Scaffold(
      drawer: const ShowDrawer(),
      appBar: AppBar(
        backgroundColor: Constant.pink,
        title: const Text("Favorite",style: TextStyle(color: Colors.white),),
        iconTheme:const IconThemeData(color: Colors.white),
        centerTitle: true,
        actions:  [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),));
          }, icon:const  Icon(Icons.notifications_none))
        ],
      ),
      body:items.value!.docs.isEmpty?  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/fav.png",width:250),
            const Text("No favorite items available"),
          ],
        ),
      )
        :items.when(
        data: (data) {
          return SingleChildScrollView(
            padding:EdgeInsets.symmetric(horizontal: 5,vertical: 3),
            scrollDirection: Axis.vertical,
            child: MasonryGridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.docs.length,
              shrinkWrap: true,
              gridDelegate:
              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return  InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(getIndex: data.docs[index]),));
                  },
                  child: Card(
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(15),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              // color:Colors.grey,
                              image: DecorationImage(
                                  image:
                                  NetworkImage(data.docs[index]['image'])),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.docs[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                      RatingBar.builder(
                                        itemSize: 15,
                                        initialRating: data.docs[index]['rating']['rate'] == 3?3.0:data.docs[index] ['rating']['rate'],
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        unratedColor: Colors.grey,
                                        itemPadding:
                                        const EdgeInsets.only(right: 2),
                                        itemBuilder: (context, _) =>
                                        const Icon(Icons.star, color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          Apis.updateProductRating(rating, data.docs[index]);
                                        },
                                      ),
                                      Text('\$ ${data.docs[index]['price']}', style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  )),
                              IconButton(
                                  onPressed: ()async {
                                    await Apis.toggleFavorites(data.docs[index]);
                                  },
                                  icon:  Icon(Icons.favorite))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } ,
        error: (err, stack) {
          return Text("error");
        } ,
        loading: () {
          return Center(
            child: CircularProgressIndicator(
              color: Constant.pink,
            ),
          );
        },

      ),



        );
  }
}
