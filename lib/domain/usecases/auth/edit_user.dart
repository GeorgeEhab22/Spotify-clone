import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/models/auth/edit_user.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/entities/auth/user.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/service_locator.dart';

class EditUserUseCase implements UseCase<Either,EditUser> {
  @override
  Future<Either> call({EditUser? params}) async {
    return await serviceLocator<AuthRepositry>().editUser(params!);
  }

}
