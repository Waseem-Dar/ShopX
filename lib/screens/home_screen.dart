import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/main.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/screens/details_screen.dart';
import 'package:shopapp/widget/constant.dart';
import 'package:shopapp/widget/drawer.dart';
import 'package:shopapp/widget/shimmer_loader.dart';
import '../providers/apis.dart';
import '../providers/all_provider.dart';
import 'Notification_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';





class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var imageList = [
      "assets/images/slide1.jpeg",
      "assets/images/slide2.png",
      "assets/images/slide3.jpg",
      "assets/images/slide4.jpg",
      "assets/images/sale1.jpg",];
    final data = ref.watch(productsStreamProvider);
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black12.withOpacity(0.03),
        drawer: const ShowDrawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Constant.pink,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Shop",
                style: TextStyle(
                    fontSize: 30,
                    // color: Constant.pink,
                    color: Colors.white,
                    fontFamily: "logo",
                    letterSpacing: 2),
              ),
              Image.asset(
                "assets/images/x.png",
                width: 35,
                // color: Constant.pink,
                color: Colors.white,
                height: 30,
              )
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),));
              },
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                height: 60,
                color: Constant.pink,
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          cursorColor: Colors.grey ,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search",
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constant.pink, width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Constant.pink, width: 1),
                                borderRadius: BorderRadius.circular(25)),
                            prefixIcon: Icon(Icons.search,color: Colors.black54,),
                          ),
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    MaterialButton(

                      padding: const EdgeInsets.all(6.5),
                      // color: Constant.pink,
                      color: Colors.white,
                      minWidth: 0,
                      shape: const CircleBorder(),
                      onPressed: () { FocusScope.of(context).unfocus();},
                      child:  Icon(
                        Icons.filter_list_sharp,
                        // color: Colors.white,
                        color: Constant.pink,
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                      ),
                      items: imageList.map((image) {
                        return  Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          height: mq.height * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image:  DecorationImage(
                                  image: AssetImage(image),
                                  fit: BoxFit.fill)),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Constant.pink),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(color: Constant.pink),
                        ),
                      ],
                    ),
                    data.when(data: (data) {
                      return SizedBox(
                        height: 260,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),

                          scrollDirection: Axis.horizontal,
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              getIndex: data.docs[index],
                                            )));
                              },
                              child: Card(
                                margin: EdgeInsets.only(bottom: 6,right: 4,left: 4),
                                elevation: 3,
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: SizedBox(
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 200,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data.docs[index]["image"]),
                                                  fit: BoxFit.fitHeight)),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.docs[index]["title"],
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: data.docs[index]['rating']['rate'] == 3
                                                        ? 3.0 : data.docs[index]['rating']['rate'],
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    unratedColor: Colors.grey,
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            right: 2),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      Apis.updateProductRating(rating, data.docs[index]);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      data.docs[index]["description"],
                                                      style: const TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 12),
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "\$ ${data.docs[index]["price"]}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }, error: (error, stackTrace) {
                      return  Center(
                          child: Text(error.toString()));
                    }, loading: () {
                      return SizedBox(
                        height: 250,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const ShimmerLoading();
                            }),
                      );
                    }),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Constant.pink),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(color: Constant.pink),
                        ),
                      ],
                    ),

                    data.when(
                      data: (data) {
                        return MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.docs.length,
                          shrinkWrap: true,
                          crossAxisSpacing:10 ,
                          mainAxisSpacing: 10,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius:BorderRadius.circular(15) ,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        getIndex: data.docs[index],
                                      ),
                                    ));
                              },
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                margin: EdgeInsets.zero,
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
                                              image: NetworkImage(
                                                  data.docs[index]['image'])),
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                  ),
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: data.docs[index]
                                                                    ['rating']
                                                                ['rate'] ==
                                                            3
                                                        ? 3.0
                                                        : data.docs[index]['rating']
                                                            ['rate'],
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    unratedColor: Colors.grey,
                                                    itemPadding:
                                                        const EdgeInsets.only(
                                                            right: 2),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      Apis.updateProductRating(rating, data.docs[index]);
                                                    },
                                                  ),
                                                  Text(
                                                    '\$ ${data.docs[index]['price']}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )),
                                          IconButton(
                                              onPressed: () async {
                                                await Apis.toggleFavorites(data.docs[index]);

                                              },
                                            icon: Consumer(
                                              builder: (context, ref, child) {
                                                final favoritesSnapshot = ref.watch(favoriteStreamProvider);

                                                // Check if the product exists in the favorites collection
                                                final isFav = favoritesSnapshot.maybeWhen(
                                                  data: (docs) {
                                                    return docs.docs.any((favDoc) => favDoc.id == data.docs[index].id);
                                                  },
                                                  orElse: () => false,
                                                ) ?? false;
                                                return Icon(
                                                  isFav ? Icons.favorite : Icons.favorite_border_outlined,

                                                );
                                              },
                                            ),)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) => const Center(
                          child: Text("Please check network connection")),
                      loading: () {
                        return SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
