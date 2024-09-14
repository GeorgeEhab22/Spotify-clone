import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/app_bar/basic_appBar.dart';
import 'package:spotify_project/common/songs/songs.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/favorite/bloc/cubit/favorite_songs_cubit.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        isHome: true,
        title: Text('Favorite songs'),
        color: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
        child: Column(
          children: [
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return Center(
                    child: const CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                }

                if (state is FavoriteSongsLoaded) {
                  // Handle the case where no songs are returned
                  if (state.favoriteSongs.isEmpty) {
                    return Center(child: Text("No favorite songs found"));
                  }
                  return SongsWidget(songs: state.favoriteSongs);
                }

                if (state is FavoriteSongsFailure) {
                  return Center(child: Text("Failed to load favorite songs"));
                }

                // Default case if no state matches
                return Center(child: Text("Something went wrong"));
              },
            )
          ],
        ),
      ),
    );
  }
}
