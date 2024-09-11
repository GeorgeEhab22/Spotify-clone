import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/assets/app_vectors.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatefulWidget {
  const NewsSongs({super.key});

  @override
  State<NewsSongs> createState() => _NewsSongsState();
}

class _NewsSongsState extends State<NewsSongs> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is NewsSongsLoaded) {
              return songs(state.songs, context.isDarkMode);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget songs(List<SongEntity> songs, bool isDarkMode) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final imageUrl =
            '${AppUrls.coverFirestore}${Uri.encodeComponent(songs[index].title)}-${Uri.encodeComponent(songs[index].artist)}.jpg?${AppUrls.mediaAlt}';

        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => SongPlayer(
                        songEntity: songs[index],
                      ))),
          child: SizedBox(
            width: 200,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: Stack(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 30,
                        height: 30,
                        transform: Matrix4.translationValues(8, 8, 0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode
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
                    )
                  ]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        textAlign: TextAlign.left,
                        songs[index].title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? const Color(0xffE1E1E1)
                                : Colors.black),
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        textAlign: TextAlign.left,
                        songs[index].artist,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: isDarkMode
                                ? const Color(0xffE1E1E1)
                                : Colors.black),
                      ),
                    )),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 14);
      },
      itemCount: songs.length,
    );
  }
}
