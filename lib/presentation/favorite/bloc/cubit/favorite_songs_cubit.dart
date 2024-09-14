import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/get_favorite_songs.dart';
import 'package:spotify_project/service_locator.dart';

part 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());
   List<SongEntity> favoriteSongs = [];

  Future<void> getFavoriteSongs() async {
   
   var result  = await serviceLocator<GetFavoriteSongsUseCase>().call();
   
   result.fold(
    (l){
      emit(
        FavoriteSongsFailure()
      );
    },
    (r){
      favoriteSongs = r;
      if (!isClosed)
     { emit(
        FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
      );}
    }
  );
}

 void removeSong(int index) {
   favoriteSongs.removeAt(index);
   emit(
     FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
   );
 }
}
