import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopapp/providers/cart_provider.dart';
// import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/home_screen.dart';
import 'package:shopapp/screens/profile_screen.dart';
import 'package:shopapp/screens/favorite_screen.dart';
import 'package:shopapp/widget/constant.dart';
import '../providers/favorite_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
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

class _TabScreenState extends ConsumerState<TabScreen> {
  @override
  Widget build(BuildContext context ) {
    final itemCount = ref.watch(favoriteStreamProvider);
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
              icon:itemCount.when(
                loading: () => CircularProgressIndicator(),
                error: (error, _) => Text(""),
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
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Consumer(builder: (context, ref, _) {
                final itemCount = ref.watch(CartItemsCountProvider);
                final isEmpty = itemCount > 0;
                return Badge(
                  backgroundColor: Colors.red,
                  padding:EdgeInsets.symmetric(horizontal: 5) ,
                  offset: Offset(10,-10),
                  label: Text(itemCount.toString()),
                  isLabelVisible: isEmpty,
                  child: Icon(
                    _currentIndex == 2
                        ? Icons.shopping_cart_rounded
                        : Icons.shopping_cart_outlined,
                  ),
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
