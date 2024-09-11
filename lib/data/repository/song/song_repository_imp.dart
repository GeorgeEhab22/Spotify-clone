import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class SongRepositoryImp extends SongsRepository {
  @override
  Future<Either> getNewsSong() async {
    return await serviceLocator<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await serviceLocator<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await serviceLocator<SongFirebaseService>()
        .addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await serviceLocator<SongFirebaseService>().isFavoriteSong(songId);
  }
}
