import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/service_locator.dart';

class SignupUseCase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async{
    return await serviceLocator<AuthRepositry>().signup(params!);
  }
}
