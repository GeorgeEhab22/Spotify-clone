import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/main.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_project/presentation/choose_mode/pages/theme_icon.dart';
import 'package:spotify_project/presentation/enter_app/enter_app.dart';
import 'package:spotify_project/presentation/logo/logo.dart';

class ChooseMode extends StatelessWidget {
  const ChooseMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.chooseModeImage,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              const Logo(),
              const Spacer(),
              const Text(
                'Choose mode',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                color: Colors.black.withOpacity(0.15),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ThemeIcon(
                    vectors: AppVectors.darkMode,
                    mode: 'dark mode',
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  ThemeIcon(
                    vectors: AppVectors.lightMode,
                    mode: 'light mode',
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: BasicAppButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnterApp(),
                            ));
                      },
                      title: 'Continue'))
            ],
          )
        ],
      ),
    );
  }
}
