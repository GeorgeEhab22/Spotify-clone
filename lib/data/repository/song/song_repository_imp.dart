import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class SongRepositoryImp extends SongsRepository {
  @override
  Future<Either> getNewsSong() async{
    return await serviceLocator<SongFirebaseService>().getNewsSongs();
  }
}
