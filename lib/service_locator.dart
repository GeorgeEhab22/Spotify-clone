import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/auth/auth_repositry_imp.dart';
import 'package:spotify_project/data/repository/song/song_repository_imp.dart';
import 'package:spotify_project/data/sources/auth/auth_firbase_service.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/domain/usecases/song/get_news_songs.dart';

final serviceLocator = GetIt.instance;
Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirbaseService>(AuthFirbaseServiceImp());
  serviceLocator
      .registerSingleton<SongFirebaseService>(SongFirebaseServiceImp());

  serviceLocator.registerSingleton<AuthRepositry>(AuthRepositryImp());
  serviceLocator.registerSingleton<SongRepositoryImp>(SongRepositoryImp());

  serviceLocator.registerSingleton<SignupUseCase>(SignupUseCase());
  serviceLocator.registerSingleton<SigninUseCase>(SigninUseCase());
  serviceLocator.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
}
