import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/common/navigation_bar/custum_buttom_navigation_bar.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/home/widgets/news_songs.dart';
import 'package:spotify_project/presentation/home/widgets/playList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Add listener to TabController to rebuild when the tab changes
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButtomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with disappearing feature
          SliverAppBar(
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: SvgPicture.asset(
              AppVectors.logo,
              height: 40,
              width: 40,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: tabs(context),
            ),
          ),
          // SliverToBoxAdapter for topAppCard and other content
          SliverToBoxAdapter(
            child: Column(
              children: [
                _tabController.index == 0 ? topAppCard() : const SizedBox(),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 260,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _tabController.index == 0
                          ? const NewsSongs()
                          : const SizedBox(),
                      Container(), // Placeholder for Video
                      Container(), // Placeholder for Artists
                      Container(), // Placeholder for Podcasts
                    ],
                  ),
                ),
                _tabController.index == 0 ?  PlayList() : const SizedBox(),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
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
        ],
      ),
    );
  }
}

// topAppCard Widget for the upper card section
Widget topAppCard() {
  return Center(
    child: SizedBox(
      height: 170, // Height of the card
      child: Stack(
        clipBehavior: Clip.none, // Allows content to overflow the parent bounds
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(AppVectors.topCard),
          ),
          Positioned(
            bottom: -9, // Increased bottom value for better image alignment
            right: 10, // Adjusted for better image positioning
            child: Image.asset(
              AppImages.homeTopArtist,
              height: 200, // Increased image height for larger display
            ),
          ),
        ],
      ),
    ),
  );
}
