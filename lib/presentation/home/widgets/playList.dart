import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:spotify_project/common/app_bar/appBar.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_state.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
         
          if (state is PlayListLoaded) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Playlist',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? const Color(0xffDBDBDB)
                                : const Color(0xff131313)),
                      ),
                      Text(
                        'see more',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: context.isDarkMode
                                ? const Color(0xffC6C6C6)
                                : const Color(0xff131313)),
                      )
                    ],
                  ),
                ),
                songs(state.songs),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget songs(List<SongEntity> songs) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.isDarkMode
                              ? AppColors.darkGrey
                              : AppColors.lightGrey),
                      child: context.isDarkMode
                          ? SvgPicture.asset(
                              AppVectors.darkPlayIcon,
                              fit: BoxFit.none,
                            )
                          : SvgPicture.asset(
                              AppVectors.lightPlayIcon,
                              fit: BoxFit.none,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songs[index].title,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? const Color(0xffD6D6D6)
                                    : Colors.black),
                          ),
                          Text(
                            songs[index].artist,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: context.isDarkMode
                                    ? const Color(0xffD6D6D6)
                                    : Colors.black),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    songs[index].duration,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: context.isDarkMode
                            ? const Color(0xffD6D6D6)
                            : Colors.black),
                  ),
                  const SizedBox(width: 30,),
                  context.isDarkMode
                      ? SvgPicture.asset(AppVectors.darkHeartIcon)
                      : SvgPicture.asset(AppVectors.lightHeartIcon),
                      const SizedBox(width: 10,)
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: 30,
            ),
        itemCount: songs.length);
  }
}
