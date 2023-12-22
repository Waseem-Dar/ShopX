import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/main.dart';
import 'package:shopapp/providers/cart_provider.dart';
import 'package:shopapp/screens/Notification_screen.dart';
import 'package:shopapp/widget/constant.dart';
import 'package:shopapp/widget/drawer.dart';

import 'details_screen.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartList = ref.watch(itemsProvider);
    final itemCounts = ref.watch(itemCountsProvider);

    final totalProvider = Provider<double>((ref) {
      double total = 0;

      for (int i = 0; i < cartList.length; i++) {
        final itemPrice = cartList[i]['price'];
        final itemCount = itemCounts[i];
        total += itemPrice * itemCount;
      }
      return total;
    });
    final total = ref.watch(totalProvider);

    return Scaffold(
      drawer: const ShowDrawer(),
      appBar: AppBar(
        backgroundColor: Constant.pink,
        iconTheme:const IconThemeData(color: Colors.white),
        title: const Text("Cart",style: TextStyle(color: Colors.white),),

        centerTitle: true,
        actions:  [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>const  NotificationScreen(),));
          }, icon:const  Icon(Icons.notifications_none)),
        ],
      ),
      body: cartList.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 250,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/box.png"),
                              fit: BoxFit.fitHeight)),
                    ),
                    const SizedBox(height: 15,),
                    const Text(
                      "Your cart is empty 🤔",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5,),
                    const Text(
                      "Explore products and shop your favorite items",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        final itemCount = itemCounts[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(getIndex: cartList[index],),));
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Card(
                                elevation: 8,
                                color: Colors.white,
                                surfaceTintColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Card(
                                            elevation: 8,
                                            color: Colors.white,
                                            surfaceTintColor: Colors.white,
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              height: double.infinity,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        cartList[index]
                                                            ["image"])),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SizedBox(
                                            width: 90,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  cartList[index]["title"],
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(cartList[index]["category"]),
                                                const Expanded(child: SizedBox()),
                                                Text(
                                                  "\$  ${cartList[index]["price"]}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                ref
                                                    .read(itemsProvider.notifier)
                                                    .removeItem(cartList[index]);
                                              },
                                              child: const Card(
                                                  margin: EdgeInsets.zero,
                                                  elevation: 10,
                                                  color: Colors.white,
                                                  surfaceTintColor: Colors.white,
                                                  child: Icon(
                                                    Icons.dangerous_sharp,
                                                    color: Colors.red,
                                                  ))),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    ref
                                                        .watch(itemCountsProvider
                                                            .notifier)
                                                        .increment(index);
                                                  });
                                                },
                                                child: SizedBox(
                                                  width: 23,
                                                  height: 23,
                                                  child: Card(
                                                      elevation: 5,
                                                      margin: EdgeInsets.zero,
                                                      color: Constant.pink,
                                                      surfaceTintColor:
                                                          Constant.pink,
                                                      child: const Center(
                                                          child: Text(
                                                        "+",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.white),
                                                      ))),
                                                ),
                                              ),
                            // Count
                                              SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Card(
                                                    elevation: 5,
                                                    margin: EdgeInsets.zero,
                                                    color: Colors.white,
                                                    shape: const StadiumBorder(),
                                                    surfaceTintColor:
                                                        Colors.white,
                                                    child: Center(
                                                        child: Text(
                                                      itemCount.toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                      ),
                                                    ))),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    ref
                                                        .watch(itemCountsProvider
                                                            .notifier)
                                                        .decrement(index);
                                                  });
                                                },
                                                child: SizedBox(
                                                  width: 23,
                                                  height: 23,
                                                  child: Card(
                                                      elevation: 5,
                                                      margin: EdgeInsets.zero,
                                                      color: Constant.pink,
                                                      surfaceTintColor:
                                                          Constant.pink,
                                                      child: const Center(
                                                          child: Text(
                                                        "-",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                            color: Colors.white),
                                                      ))),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                    const SizedBox(
                      height: 90,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0),
                                Colors.white,
                                Colors.white,
                              ]),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$ ${total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )
                              ],
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Constant.pink,
                                  fixedSize: const Size(150, 50),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Pay Now",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
