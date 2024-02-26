import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:retaste_app/presentation/restaurant_favorite_screen.dart';
import 'package:retaste_app/presentation/restaurant_list_screen.dart';
import 'package:retaste_app/presentation/restaurant_setting_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _pageController = PageController(initialPage: 0);

  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const RestaurantListScreen(),
    const RestaurantFavoriteScreen(),
    const RestaurantSettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: false,
              shadowElevation: 5,
              notchColor: Theme.of(context).colorScheme.primary,
              removeMargins: false,
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.grey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Home Page',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  ),
                  activeItem: Icon(
                    Icons.favorite,
                    color: Colors.white,
                  ),
                  itemLabel: 'Favorite Page',
                ),
                BottomBarItem(
                    inActiveItem: Icon(
                      Icons.settings,
                      color: Colors.grey,
                    ),
                    activeItem: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    itemLabel: 'Settings Page'),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
              kIconSize: 24.0,
              kBottomRadius: 28.0)
          : null,
    );
  }
}
