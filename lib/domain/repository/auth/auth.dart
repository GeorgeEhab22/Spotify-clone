import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';

abstract class AuthRepositry {
  Future<Either> signup(CreateUserReq creatUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  
}
