part of 'profile_info_cubit.dart';

@immutable
sealed class ProfileInfoState {}

final class ProfileInitial extends ProfileInfoState {}
class ProfileInfoLoading extends ProfileInfoState {}

class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;

  ProfileInfoLoaded({required this.userEntity});
}

class ProfileInfoFailure extends ProfileInfoState {}
