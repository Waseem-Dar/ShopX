import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/providers/favorite_provider.dart';
import 'package:shopapp/providers/home_provider.dart';
import 'package:shopapp/screens/Notification_screen.dart';
import 'package:shopapp/screens/details_screen.dart';
import 'package:shopapp/widget/drawer.dart';

import '../widget/constant.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  items = ref.watch(favoriteItemsProvider);
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
      body:items.isEmpty? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/fav.png",width:250),
            const Text("No favorite items available"),
          ],
        ),
      ):SingleChildScrollView(
        padding:EdgeInsets.symmetric(horizontal: 5,vertical: 3),
        scrollDirection: Axis.vertical,
        child: MasonryGridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          shrinkWrap: true,
          gridDelegate:
          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return  InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(getIndex: items[index]),));
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
                              NetworkImage(items[index]['image'])),
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
                                    items[index]['title'],
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                  RatingBar.builder(
                                    itemSize: 15,
                                    initialRating: items[index]['rating']['rate'] == 3?3.0:items[index] ['rating']['rate'],
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
                                    },
                                  ),
                                  Text('\$ ${items[index]['price']}', style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          IconButton(
                              onPressed: () {
                                ref.read(favoriteItemsProvider.notifier).removeItem(items[index]);
                              },
                              icon:  Icon(items.contains(items[index])?Icons.favorite:Icons.favorite_border_outlined))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      

        );
  }
}
