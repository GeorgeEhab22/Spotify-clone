import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_project/common/favorite_button/favorite_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player.dart';

class SongsWidget extends StatelessWidget {
  final List<SongEntity> songs;
  const SongsWidget({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SongPlayer(
                              songEntity: songs[index],
                            ))),
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
