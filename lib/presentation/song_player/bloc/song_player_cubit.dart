import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_state.dart';
import 'package:spotify_project/service_locator.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  late AudioPlayer audioPlayer;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer = AudioPlayer(); // Initialize for both web and mobile platforms

    // Listening to the position stream
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    // Listening to the duration stream
    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        songDuration = duration;
      }
    });
  }

  void updateSongPlayer() {
    if (!isClosed) {
      // Check if the cubit is closed before emitting a state
      emit(SongPlayerLoaded());
    }
  }

  Future<void> loadSong(String url) async {
    try {
      // Use just_audio methods for both web and mobile, as just_audio_web will handle web support
      await audioPlayer.setUrl(url);
      if (!isClosed) {
        // Check if the cubit is closed before emitting a state
        emit(SongPlayerLoaded());
      }
    } catch (e) {
      print("Error loading song: $e");
      if (!isClosed) {
        // Check if the cubit is closed before emitting a state
        emit(SongPlayerFailure());
      }
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    if (!isClosed) {
      // Check if the cubit is closed before emitting a state
      emit(SongPlayerLoaded());
    }
  }


  @override
  Future<void> close() {
    audioPlayer.dispose(); // Clean up audio player resources
    return super.close(); // Ensure the cubit is properly closed
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    if (!isClosed) {
      // Check if the cubit is closed before emitting a state
      emit(SongPlayerLoaded());
    }
  }
}
