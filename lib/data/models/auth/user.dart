import 'package:spotify_project/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  UserModel({
    this.fullName,
    this.email,
  });
  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

extension SongModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName!,
      email: email!,
    );
  }
}
