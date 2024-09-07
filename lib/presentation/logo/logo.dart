import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.width, this.hight});
  final double? width;
  final double? hight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
            alignment: Alignment.topCenter,
            child: SvgPicture.asset(
              AppVectors.logo,
              width: width,
              height: hight,
            )));
  }
}
