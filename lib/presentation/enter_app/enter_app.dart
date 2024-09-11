import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/app_bar/basic_appBar.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/logo/logo.dart';
import 'package:spotify_project/presentation/register/register.dart';
import 'package:spotify_project/presentation/signin/signin.dart';

class EnterApp extends StatelessWidget {
  EnterApp({super.key});
  Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        isHome: false,
      ),
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(AppVectors.topPattern)),
          Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(AppVectors.bottomPattern)),
          Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(AppImages.enterAppImage)),
          Column(children: [
            const Padding(
              padding: EdgeInsetsDirectional.only(top: 100),
              child: Logo(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Enjoy listening to music',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Text(
                'Spotify is a proprietary Swedish audio streaming and media services provider ',
                style: TextStyle(
                    color: AppColors.customGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: BasicAppButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Register())),
                    title: 'Register',
                    height: 80,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: TextButton(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Signin()),
                      ),
                    ))
              ]),
            )
          ])
        ],
      ),
    );
  }
}
