import 'dart:developer';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shopapp/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/main.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopapp/providers/favorite_provider.dart';
import 'package:shopapp/screens/details_screen.dart';
import 'package:shopapp/widget/constant.dart';
import 'package:shopapp/widget/drawer.dart';
import 'package:shopapp/widget/shimmer_loader.dart';

import 'Notification_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(favoriteItemsProvider);
    var productData = ref.watch(futureProductProvider);
    mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                      onPressed: () {},
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      height: mq.height * .2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/sale1.jpg"),
                              fit: BoxFit.fill)),
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
                    productData.when(data: (data) {
                      return SizedBox(
                        height: 260,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              getIndex: data[index],
                                            )));
                              },
                              child: Card(
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
                                                      data[index]["image"]),
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
                                                    data[index]["title"],
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                    maxLines: 1,
                                                  ),
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: data[index]['rating']['rate'] == 3
                                                        ? 3.0 : data[index]['rating']['rate'],
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
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      data[index]["description"],
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
                                              "\$ ${data[index]["price"]}",
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
                      return const Center(
                          child: Text("Please check network connection"));
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
                    productData.when(
                      data: (data) {
                        return MasonryGridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        getIndex: data[index],
                                      ),
                                    ));
                              },
                              child: Card(
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                elevation: 3,
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
                                                  data[index]['image'])),
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
                                                    data[index]['title'],
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    maxLines: 1,
                                                  ),
                                                  RatingBar.builder(
                                                    itemSize: 15,
                                                    initialRating: data[index]
                                                                    ['rating']
                                                                ['rate'] ==
                                                            3
                                                        ? 3.0
                                                        : data[index]['rating']
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
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                  Text(
                                                    '\$ ${data[index]['price']}',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                if (items.contains(data[index])) {
                                                  ref
                                                      .read(favoriteItemsProvider
                                                          .notifier)
                                                      .removeItem(data[index]);
                                                } else {
                                                  ref
                                                      .read(favoriteItemsProvider
                                                          .notifier)
                                                      .addItem(data[index]);
                                                  log(index.toString());
                                                }
                                              },
                                              icon: Icon(items.contains(data[index])
                                                  ? Icons.favorite
                                                  : Icons.favorite_border_outlined))
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
                        return Center(
                          child: CircularProgressIndicator(color: Constant.pink),
                        );
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
