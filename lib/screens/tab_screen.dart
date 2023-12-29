import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/all_provider.dart';
// import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/home_screen.dart';
import 'package:shopapp/screens/profile_screen.dart';
import 'package:shopapp/screens/favorite_screen.dart';
import 'package:shopapp/widget/constant.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

int _currentIndex = 0;
final List _tabs = [
  const HomeScreen(),
  const FavoriteScreen(),
  const CartScreen(),
  const ProfileScreen(),
];

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context ) {
    setState(() {

    });


    return SafeArea(
      top: false,
      child: Scaffold(
        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(color: Constant.pink),
          selectedIconTheme: IconThemeData(color: Constant.pink),
          selectedItemColor: Constant.pink,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:Consumer(builder: (context, ref, child) {
                final favItemCount = ref.watch(favoriteStreamProvider);
                return favItemCount.when(
                  loading: () => Icon(Icons.favorite_border_outlined,
                    color: Constant.pink,),
                  error: (error, _) => Icon(Icons.favorite_border_outlined,color:Colors.red,),
                  data: (data) {
                    final count = data.docs.length;
                    return Badge(

                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      offset: const Offset(10, -10),
                      label: Text(count.toString()),
                      isLabelVisible:count==0?false:true,
                      child: Icon(
                        _currentIndex == 1
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                      ),
                    );
                  },
                );
              },),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon:Consumer(builder: (context, ref, child) {
                final cartItemCount = ref.watch(cartStreamProvider);
                return cartItemCount.when(
                  error: (error, stackTrace) =>  Icon(Icons.shopping_cart_outlined,color: Colors.red,),
                  loading: () => Icon(Icons.shopping_cart_outlined,color: Constant.pink,),
                  data: (data) {
                    final count = data.docs.length;
                    return Badge(
                      backgroundColor: Colors.red,
                      padding:EdgeInsets.symmetric(horizontal: 5) ,
                      offset: Offset(10,-10),
                      label: Text(count.toString()),
                      isLabelVisible: count == 0?false:true,
                      child: Icon(
                        _currentIndex == 2
                            ? Icons.shopping_cart_rounded
                            : Icons.shopping_cart_outlined,
                      ),
                    );
                  },
                );
              },),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon:  Icon(
                _currentIndex == 3 ? Icons.person : Icons.person_2_outlined,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
