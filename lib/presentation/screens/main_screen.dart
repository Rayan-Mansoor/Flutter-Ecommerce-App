import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'home_screen.dart';
import 'cart_screen.dart';
import 'settings_screen.dart';
import 'package:zephyr_flutter/features/products/providers/product_notifier.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _screenIndex = 0;
  final PageController _pageController = PageController();

  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    CartScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _screenIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onPageChanged(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final cartProducts = ref.watch(
          productProvider.select((state) => state.cartProducts),
        );

        int cartCount = cartProducts.length;

        return Scaffold(
          appBar: AppBar(title: const Text("Zephyr Flutter")),
          body: PageView(
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  showBadge: cartCount > 0,
                  badgeAnimation: const badges.BadgeAnimation.rotation(
                    animationDuration: Duration(milliseconds: 500),
                    colorChangeAnimationDuration: Duration(milliseconds: 500),
                    loopAnimation: false,
                    curve: Curves.easeInOut,
                    colorChangeAnimationCurve: Curves.easeInOut,
                  ),
                  badgeContent: Text(
                    cartCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
            currentIndex: _screenIndex,
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
