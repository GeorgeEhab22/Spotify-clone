import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/app_bar/appBar.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/logo/logo.dart';
import 'package:spotify_project/presentation/register/register.dart';
import 'package:spotify_project/presentation/signin/signin.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Stack(
              children: [
                topAppCard(),
              ],
            ),
          ]),
        ));
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
            right: 10,  // Adjust as needed to place the image horizontally
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
