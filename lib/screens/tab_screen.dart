import 'package:flutter/material.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/home_screen.dart';
import 'package:shopapp/screens/profile_screen.dart';
import 'package:shopapp/screens/favorite_screen.dart';
import 'package:shopapp/widget/constant.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  @override
  State<TabScreen> createState() => _TabScreenState();
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
  Widget build(BuildContext context) {
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
              icon: Icon(
                _currentIndex == 1
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
              ),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2
                    ? Icons.shopping_cart_rounded
                    : Icons.shopping_cart_outlined,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
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
