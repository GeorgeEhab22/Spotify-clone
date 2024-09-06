import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Align(alignment: Alignment.topCenter,
            child: SvgPicture.asset(AppVectors.logo)));
  }
}