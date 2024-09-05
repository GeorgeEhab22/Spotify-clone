
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/custom_button/basic_app_button.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

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
              Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(child: SvgPicture.asset(AppVectors.logo))),
              const Spacer(),
              const Text(
                'Choose mode',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration:  BoxDecoration(
                                color: const Color(0xff30393c).withOpacity(0.5),
                                shape: BoxShape.circle,
                               ),
                             child: SvgPicture.asset(AppVectors.darkMode,fit: BoxFit.none,),   
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text('dark mode',style: TextStyle(color: AppColors.customGrey,fontSize: 17,fontWeight: FontWeight.w400),)
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: const Color(0xff30393c).withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(AppVectors.lightMode,fit: BoxFit.none,),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      const Text('light mode',style: TextStyle(color: AppColors.customGrey,fontSize: 17,fontWeight: FontWeight.w400),)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Container(color: Colors.black.withOpacity(0.15),),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: BasicAppButton(onPressed: (){}, title: 'Continue'))
            ],
          )
        ],
      ),
    );
  }
}
