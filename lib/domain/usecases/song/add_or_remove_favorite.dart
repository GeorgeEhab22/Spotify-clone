import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/repository/song/song_repository_imp.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class AddOrRemoveFavoriteUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await serviceLocator<SongRepositoryImp>().addOrRemoveFavoriteSongs(params!);
  }
}
