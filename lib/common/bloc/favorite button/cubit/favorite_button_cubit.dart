import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify_project/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify_project/service_locator.dart';

part 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());
  Future<void> favoriteButtonUpdated(String songId) async {
    var result =
        await serviceLocator<AddOrRemoveFavoriteUseCase>().call(params: songId);
    result.fold((l) {}, (isFavorite) {
      emit(FavoriteButtonUpdated(isFavorite: isFavorite));
    });
  }
}
