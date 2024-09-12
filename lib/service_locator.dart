import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/auth/auth_repositry_imp.dart';
import 'package:spotify_project/data/repository/song/song_repository_imp.dart';
import 'package:spotify_project/data/sources/auth/auth_firbase_service.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favorite.dart';
import 'package:spotify_project/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_playlist.dart';
import 'package:spotify_project/domain/usecases/song/is_favorite_song.dart';
import 'package:spotify_project/domain/usecases/song/next_song.dart';

final serviceLocator = GetIt.instance;
Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirbaseService>(AuthFirbaseServiceImp());
  serviceLocator
      .registerSingleton<SongFirebaseService>(SongFirebaseServiceImp());

  serviceLocator.registerSingleton<AuthRepositry>(AuthRepositryImp());
  serviceLocator.registerSingleton<SongRepositoryImp>(SongRepositoryImp());
  serviceLocator.registerSingleton<SongsRepository>(SongRepositoryImp());


  serviceLocator.registerSingleton<SignupUseCase>(SignupUseCase());
  serviceLocator.registerSingleton<SigninUseCase>(SigninUseCase());
  serviceLocator.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  serviceLocator.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());
  serviceLocator.registerSingleton<NextSongUseCase>(NextSongUseCase());


  serviceLocator.registerSingleton<AddOrRemoveFavoriteUseCase>(
      AddOrRemoveFavoriteUseCase()
      );
  serviceLocator
      .registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase()
      );
}
