import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:spotify_project/common/app_bar/basic_appBar.dart';
import 'package:spotify_project/common/favorite_button/favorite_button.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_state.dart';

class SongPlayer extends StatefulWidget {
  final SongEntity songEntity;
  const SongPlayer({super.key, required this.songEntity});

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  bool isClicked = false;
  bool repeat = false;
  bool repeatOne = false;
  int repeatTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        isHome: false,
        title: const Text(
          'Now Playing',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        action: IconButton(
          icon: const Icon(Icons.more_vert_outlined),
          onPressed: () {},
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
            '${AppUrls.songFirestore}${Uri.encodeComponent(widget.songEntity.title)}-${Uri.encodeComponent(widget.songEntity.artist)}.mp3?${AppUrls.mediaAlt}',
          ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              songCover(context),
              songDetails(context),
              const SizedBox(height: 30),
              songPlayer(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget songCover(BuildContext context) {
    final imageUrl =
        '${AppUrls.coverFirestore}${Uri.encodeComponent(widget.songEntity.title)}-${Uri.encodeComponent(widget.songEntity.artist)}.jpg?${AppUrls.mediaAlt}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          image:
              DecorationImage(fit: BoxFit.cover, image: NetworkImage(imageUrl)),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget songDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.songEntity.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.songEntity.artist,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          FavoriteButton(songEntity: widget.songEntity)
        ],
      ),
    );
  }

  Widget songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is SongPlayerLoaded) {
          final songPlayerCubit =
              BlocProvider.of<SongPlayerCubit>(context); // Access cubit here
          return Column(
            children: [
              Slider(
                thumbColor: AppColors.primary,
                value: songPlayerCubit.songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: songPlayerCubit.songDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  songPlayerCubit.seekTo(Duration(seconds: value.toInt()));
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(durationFormatting(songPlayerCubit.songPosition)),
                  Text(durationFormatting(songPlayerCubit.songDuration)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          repeatTab == 0 ? repeat = !repeat : repeat;
                          repeat == false ? repeatTab++ : repeatTab;
                          repeatTab >= 2 ? repeatTab = 0 : repeatTab;

                        });
                      },
                      child: Icon(
                        repeat
                            ? Icons.repeat_on_rounded
                            : repeatTab == 1
                                ? Icons.repeat_one
                                : Icons.repeat_rounded,
                        color: context.isDarkMode
                            ? const Color(0xffA7A7A7)
                            : const Color(0xff363636),
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.skip_previous_rounded,
                        color: context.isDarkMode
                            ? const Color(0xffA7A7A7)
                            : const Color(0xff363636),
                        size: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<SongPlayerCubit>().playOrPauseSong();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.primary),
                        child: Icon(
                            context.read<SongPlayerCubit>().audioPlayer.playing
                                ? Icons.pause
                                : Icons.play_arrow),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.skip_next_rounded,
                        color: context.isDarkMode
                            ? const Color(0xffA7A7A7)
                            : const Color(0xff363636),
                        size: 30,
                      ),
                    ), GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.shuffle_rounded,
                        color: context.isDarkMode
                            ? const Color(0xffA7A7A7)
                            : const Color(0xff363636),
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  String durationFormatting(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
