import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist.dart';
import 'package:spotify_project/presentation/home/bloc/playlist_state.dart';
import 'package:spotify_project/service_locator.dart';


class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlayListLoading());

  Future<void> getPlaylist() async {
  if (isClosed) return; // Avoid emitting states if cubit is closed

  var returnedSongs = await serviceLocator<GetPlayListUseCase>().call();
  returnedSongs.fold((l) {
    if (isClosed) return; // Avoid emitting states if cubit is closed

    // Handle error state
    emit(PlayListLoadFailure());
  }, (data) {
    if (isClosed) return; // Avoid emitting states if cubit is closed

    // Check if data is valid
    if (data.isNotEmpty) {
      emit(PlayListLoaded(songs: data));
    } else {
      emit(PlayListLoadFailure());
    }
  });
}

}
