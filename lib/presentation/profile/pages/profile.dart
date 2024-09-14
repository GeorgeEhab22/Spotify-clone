import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconly/iconly.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_images.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_project/presentation/profile/bloc/cubit/profile_info_cubit.dart';
import 'package:spotify_project/common/app_bar/basic_appBar.dart';
import 'package:spotify_project/presentation/choose_mode/pages/theme_icon.dart';
import 'package:spotify_project/presentation/profile/pages/profile_buttons.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        isHome: true,
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          profileInfo(context),
          const SizedBox(
            height: 30,
          ),
          const ProfileButton(
            button: 'change mode',
            logout: false,

          ),
           const SizedBox(
            height: 30,
          ),
           const ProfileButton(
            button: 'change name',
            logout: false,

          ),
            const SizedBox(
            height: 30,
          ),
           const ProfileButton(
            button: 'change email',
            logout: false,
          ),
            const SizedBox(
            height: 30,
          ),
          
           const ProfileButton(
            button: 'Log out',logout: true,
            
          ),
          

        ],
      ),
    );
  }

  Widget profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.8,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80),
            bottomRight: Radius.circular(80),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          AppImages.profileImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    state.userEntity.email!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Text('Cannot load user profile data');
            }
            return Container();
          },
        ),
      ),
    );
  }
}
