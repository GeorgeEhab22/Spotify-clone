import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/app_bar/appBar.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/common/navigation_bar/custum_buttom_navigation_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/home/widgets/news_songs.dart';
import 'package:spotify_project/presentation/home/widgets/playList.dart';

class home extends StatefulWidget {
  const home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomButtomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
        ),
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              topAppCard(),
              tabs(),
              SizedBox(
                height: 260,
                child: TabBarView(controller: _tabController, children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ]),
              ),
              const Playlist(),
            ],
          ),
        ));
  }

  Widget tabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: context.isDarkMode ? Colors.white : Colors.black,
          tabAlignment: TabAlignment.start,
          indicatorColor: AppColors.primary,
          tabs: const [
            Text(
              'News',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Video',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Artists',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Podcast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ]),
    );
  }
}

Widget topAppCard() {
  return Center(
    child: SizedBox(
      height: 170, // Height of the card (you can increase this if needed)
      child: Stack(
        clipBehavior: Clip.none, // Allows content to overflow the parent bounds
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(AppVectors.topCard),
          ),
          Positioned(
            bottom: -9, // Increase this value to move the image higher
            right: 10, // Adjust as needed to place the image horizontally
            child: Image.asset(
              AppImages.homeTopArtist,
              height: 200, // Increased image height for a bigger display
            ),
          ),
        ],
      ),
    ),
  );
}
