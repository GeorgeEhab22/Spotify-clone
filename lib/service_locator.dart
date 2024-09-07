import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/auth/auth_repositry_imp.dart';
import 'package:spotify_project/data/sources/auth/auth_firbase_service.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';

final serviceLocator = GetIt.instance;
Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirbaseService>(AuthFirbaseServiceImp());
  serviceLocator.registerSingleton<AuthRepositry>(AuthRepositryImp());
  serviceLocator.registerSingleton<SignupUseCase>(SignupUseCase());
  serviceLocator.registerSingleton<SigninUseCase>(SigninUseCase());
  

}
