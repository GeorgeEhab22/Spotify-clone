import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/data/models/auth/user.dart';
import 'package:spotify_project/data/sources/auth/auth_firbase_service.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/service_locator.dart';

class AuthRepositryImp extends AuthRepositry {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await serviceLocator<AuthFirbaseService>().signin(signinUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq creatUserReq) async {
    return await serviceLocator<AuthFirbaseService>().signup(creatUserReq);
  }
  
  @override
  Future<Either> getUser() async {
    return await serviceLocator<AuthFirbaseService>(). getUser();
  
  }
}
