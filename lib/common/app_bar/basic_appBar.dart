import 'package:flutter/material.dart';
import 'package:spotify_project/common/helper/is_dark.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;

  final bool isHome;
  const BasicAppBar({super.key, this.title, required this.isHome, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [action??Container()],
        centerTitle: true,
        
        title: title,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:isHome?const SizedBox(): IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.isDarkMode
                    ? Colors.white.withOpacity(0.03)
                    : Colors.black.withOpacity(0.04)),
            child: Icon(Icons.arrow_back_ios_new,
                size: 16,
                color: context.isDarkMode ? Colors.white : Colors.black),
          ),
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}