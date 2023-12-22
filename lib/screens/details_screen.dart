import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/providers/home_provider.dart';
import 'package:shopapp/providers/favorite_provider.dart';
import 'package:shopapp/widget/constant.dart';

class DetailScreen extends ConsumerWidget {
  final  dynamic getIndex;
  const DetailScreen({super.key, required this.getIndex});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final AsyncValue<List<dynamic>> product = ref.watch(futureProductProvider);
    final items = ref.watch(favoriteItemsProvider);
    final cartItems = ref.watch(itemsProvider);
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: mq.height * .55,
                child: Card(
                  // shadowColor: Constant.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  child: Center(
                      child: Container(
                        margin: const EdgeInsets.all(60),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(getIndex["image"]),
                          ),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: const StadiumBorder(),
                      child: IconButton(
                        onPressed: () {Navigator.pop(context);},
                        icon: Icon(Icons.arrow_back_ios_new, color: Constant.pink, size: 30,),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: const StadiumBorder(),
                      child: IconButton(
                        onPressed: () {
                          if (items.contains(getIndex)) {
                            ref.read(favoriteItemsProvider.notifier).removeItem(getIndex);
                          } else {
                            ref.read(favoriteItemsProvider.notifier).addItem(getIndex);
                          }
                        },
                        icon: Icon(items.contains(getIndex)?Icons.favorite:Icons.favorite_border_outlined, color: Constant.pink, size: 30,),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 200,
                        child: Text(getIndex['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24), maxLines: 1,
                        )),
                    RatingBar.builder(
                      itemSize: 20,
                      initialRating: getIndex['rating']['rate'] == 3?3.0:getIndex ['rating']['rate'],
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      unratedColor: Colors.grey,
                      itemPadding:
                      const EdgeInsets.only(right: 4),
                      itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                      },
                    ),
                  ],
                ),

                Text("\$ ${getIndex['price']}",style:const  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),) ,
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(getIndex['description']),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constant.pink,
                  ),
                  onPressed: (){
                    if (cartItems.contains(getIndex)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text('Item is already in the cart.'),
                        ),
                      );
                    } else {
                      ref.read(itemsProvider.notifier).addItem(getIndex);
                    }
                  }, child: const Text('Add To Cart',style: TextStyle(color: Colors.white),)),
            ),
          )
        ],
      ),
    );
  }
}




