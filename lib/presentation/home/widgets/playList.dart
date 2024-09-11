import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:spotify_project/common/favorite_button/favorite_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_state.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player.dart';

class PlayList extends StatefulWidget {
  PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList>
    with SingleTickerProviderStateMixin {
  // List to keep track of whether each song is liked or not
  late List<bool> isClicked;

  @override
  void initState() {
    super.initState();
    // Initialize the list with false for all songs (none liked initially)
    isClicked = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlayListLoaded) {
            // Ensure the `isClicked` list has the correct length for the songs
            if (isClicked.length != state.songs.length) {
              isClicked = List<bool>.filled(state.songs.length, false);
            }

            return Column(
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              : const Color(0xff131313),
                        ),
                      ),
                      Text(
                        'see more',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: context.isDarkMode
                              ? const Color(0xffC6C6C6)
                              : const Color(0xff131313),
                        ),
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
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SongPlayer(
                        songEntity: songs[index],
                      ))),
          child: Row(
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
                            : AppColors.lightGrey,
                      ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            songs[index].artist,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: context.isDarkMode
                                  ? const Color(0xffD6D6D6)
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=> SongPlayer(songEntity: songs[index],))),
                child: Row(
                  children: [
                    Text(
                      songs[index].duration.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: context.isDarkMode
                            ? const Color(0xffD6D6D6)
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(width: 30),
                   FavoriteButton(songEntity: songs[index]),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 30),
      itemCount: songs.length,
    );
  }
}
