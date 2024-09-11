import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

class CustomButtomNavigationBar extends StatefulWidget {
  const CustomButtomNavigationBar({
    super.key,
    this.onTap,
    required this.currentIndex,
  });
  final Function(int)? onTap;
  final int currentIndex;
  @override
  State<CustomButtomNavigationBar> createState() =>
      _CusotmBottomNavigationBarState();
}

class _CusotmBottomNavigationBarState extends State<CustomButtomNavigationBar> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(

      color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
      height: 66,
      key: bottomNavigationKey,
      index: widget.currentIndex,
      items: [
        Icon(
          (widget.currentIndex == 0) ? IconlyBold.home : IconlyLight.home,
          color: (widget.currentIndex != 0) ? const Color(0xff737373) : AppColors.primary,
          size: (widget.currentIndex == 0) ? 32 : 24,
        ),
        Icon(
          (widget.currentIndex == 1) ? IconlyBold.heart : IconlyLight.heart,
          color: (widget.currentIndex != 1) ? const Color(0xff737373) : Colors.red,
          size: (widget.currentIndex == 1) ? 32 : 24,
        ),
        Icon(
          (widget.currentIndex == 2) ? IconlyBold.profile : IconlyLight.profile,
          color: (widget.currentIndex != 2)
              ? const Color(0xff737373)
              : const Color.fromARGB(255, 121, 185, 216),
          size: (widget.currentIndex == 2) ? 32 : 24,
        ),
      ],
      buttonBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(
        milliseconds: 400,
      ),
      onTap: widget.onTap,
      letIndexChange: (index) => true,
    );
  }
}
