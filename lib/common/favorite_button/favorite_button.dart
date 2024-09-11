import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:spotify_project/common/bloc/favorite%20button/cubit/favorite_button_cubit.dart';
import 'package:spotify_project/common/helper/is_dark.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({required this.songEntity, this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);
              },
              icon: songEntity.isFavorite
                  ? const Icon(
                      IconlyBold.heart,
                      color: Colors.redAccent,
                    )
                  : context.isDarkMode
                      ? const Icon(
                          IconlyLight.heart,
                          color: AppColors.customGrey,
                        )
                      : const Icon(
                          IconlyLight.heart,
                          color: Color(0xffB4B4B4),
                        ),
            );
          }
          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () { context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdated(songEntity.songId);},
              icon: state.isFavorite
                  ? const Icon(
                      IconlyBold.heart,
                      color: Colors.redAccent,
                    )
                  : context.isDarkMode
                      ? const Icon(
                          IconlyLight.heart,
                          color: AppColors.customGrey,
                        )
                      : const Icon(
                          IconlyLight.heart,
                          color: Color(0xffB4B4B4),
                        ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
