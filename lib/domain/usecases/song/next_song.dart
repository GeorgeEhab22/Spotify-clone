import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/repository/song/song_repository_imp.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class NextSongUseCase implements UseCase<SongEntity, SongEntity> {
  @override
 Future<SongEntity> call({SongEntity?params}) async {
    return await serviceLocator<SongRepositoryImp>().nextSong(params!);
  }
}
