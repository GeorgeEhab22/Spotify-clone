import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';

class ThemeIcon extends StatelessWidget {
  final String vectors;
  final String mode;
  static late String cMode;

  const ThemeIcon({
    super.key,
    required this.vectors,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (mode == 'dark mode') {
              context.read<ThemeCubit>().setDarkMode();
            } else if (mode == 'light mode') {
              context.read<ThemeCubit>().setLightMode();
            }
          //  cMode = mode;
          },
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xff30393c).withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  vectors,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          mode,
          style: const TextStyle(
              color: AppColors.customGrey,
              fontSize: 17,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
