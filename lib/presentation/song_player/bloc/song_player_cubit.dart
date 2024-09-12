import 'dart:math';

import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_state.dart';
import 'package:spotify_project/service_locator.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  late AudioPlayer audioPlayer;
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;
  LoopMode repeatMode = LoopMode.off;
  final SongEntity currentSong;
  SongPlayerCubit(this.currentSong) : super(SongPlayerLoading()) {
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
      if (duration.toString() == currentSong.duration) {
        nextSong(currentSong);
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

  void toggleRepeatMode() {
    switch (repeatMode) {
      case LoopMode.off:
        repeatMode = LoopMode.all;
        break;
      case LoopMode.all:
        repeatMode = LoopMode.one;
        break;
      case LoopMode.one:
        repeatMode = LoopMode.off;
        break;
    }
    audioPlayer.setLoopMode(repeatMode); // Update the loop mode in the player
    emit(SongPlayerLoaded());
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

  SongEntity nextSong(SongEntity currentSong) {
    int endPoint = SongFirebaseServiceImp.songs.length;
    for (int i = 0; i < endPoint; i++) {
      SongEntity song = SongFirebaseServiceImp.songs[i];
      if (currentSong.title == song.title && i + 1 < endPoint) {
        return SongFirebaseServiceImp.songs[i + 1];
      }
    }
    return SongFirebaseServiceImp.songs[0];
  }

  SongEntity previousSong(SongEntity currentSong) {
    int endPoint = SongFirebaseServiceImp.songs.length;
    for (int i = endPoint - 1; i > 0; i--) {
      SongEntity song = SongFirebaseServiceImp.songs[i];
      if (currentSong.title == song.title && i - 1 > 0) {
        return SongFirebaseServiceImp.songs[i - 1];
      }
    }
    return SongFirebaseServiceImp.songs[endPoint - 1];
  }

  SongEntity shuffle(SongEntity currentSong) {
    int index = getIndex(currentSong);
    Random random = Random();
    int endPoint = SongFirebaseServiceImp.songs.length;

    int randomSong = random.nextInt(endPoint);

    if (randomSong == index) {
      shuffle(currentSong);
    }
    return SongFirebaseServiceImp.songs[randomSong];
  }

  int getIndex(SongEntity currentSong) {
    int endPoint = SongFirebaseServiceImp.songs.length;
    for (int i = 0; i < endPoint; i++) {
      SongEntity song = SongFirebaseServiceImp.songs[i];
      if (currentSong.title == song.title && i + 1 < endPoint) {
        return i;
      }
    }
    return 0;
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
