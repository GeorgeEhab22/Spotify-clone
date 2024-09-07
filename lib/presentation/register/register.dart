import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/app_bar/appBar.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: SvgPicture.asset(AppVectors.logo,height: 40,width: 40,),),
      body:Column() ,
    );
  }
}