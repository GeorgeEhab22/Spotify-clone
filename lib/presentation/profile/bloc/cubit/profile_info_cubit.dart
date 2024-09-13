import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_project/domain/entities/auth/user.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/service_locator.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var user = await serviceLocator<GetUserUseCase>().call();
    user.fold((l) {
      if (!isClosed) {
        emit(ProfileInfoFailure());
      }
    }, (userEntity) {
      if (!isClosed) {
        emit(ProfileInfoLoaded(userEntity: userEntity));
      }
    });
  }
}
