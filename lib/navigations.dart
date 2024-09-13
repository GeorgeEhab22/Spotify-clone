import 'package:flutter/material.dart';
import 'package:spotify_project/common/navigation_bar/custum_buttom_navigation_bar.dart';
import 'package:spotify_project/presentation/favorite/favorite.dart';
import 'package:spotify_project/presentation/home/pages/home.dart';
import 'package:spotify_project/presentation/profile/pages/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Navigation> {
  int currentIndex = 0;
  List screens = [
    const Home(),
    const Favorite(),
    const MyAccount(),
  ];
  int bottomNavigationBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[currentIndex],
      bottomNavigationBar: CustomButtomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
    );
  }
}
