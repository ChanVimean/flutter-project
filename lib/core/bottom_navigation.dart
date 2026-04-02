import 'package:flutter/material.dart';
import 'package:project/presentation/provider/navigation_provider.dart';
import 'package:project/presentation/view/account/account_screen.dart';
import 'package:project/presentation/view/cart/cart_screen.dart';
import 'package:project/presentation/view/home/home_screen.dart';
import 'package:project/presentation/view/product/product_screen.dart';
import 'package:project/presentation/view/search/search_screen.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> screens = [
    HomeScreen(),
    ProductScreen(),
    CartScreen(),
    AccountScreen(),
    SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    return Scaffold(
      body: IndexedStack(index: navProvider.currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => navProvider.setIndex(index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}
