import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_project/service_locator.dart';

import 'news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await serviceLocator<GetNewsSongsUseCase>().call();
    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
      // Log the error
      print("Failed to load songs: $l");
    }, (data) {
      // Log the data fetched
     
      // Check if data is valid
      if (data.isNotEmpty) {
        emit(NewsSongsLoaded(songs: data));
      } else {
        emit(NewsSongsLoadFailure());
        print("No songs data available");
      }
    });
  }
}
