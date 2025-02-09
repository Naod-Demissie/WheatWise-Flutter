import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_event.dart';
import 'package:wheatwise/features/setting/edit_profile/bloc/edit_profile_state.dart';
import 'package:wheatwise/features/setting/edit_profile/repository/edit_profile_repository.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileState> {
  final EditProfileRepository editProfileRepository = EditProfileRepository();

  EditProfileBloc() : super(EditProfileInitialState()) {
    on<EditProfileEvent>((event, emit) async {
      emit(LoadingEditProfileState());
      try {
        await editProfileRepository.editProfile(
            username: event.username,
            prefix: event.prefix,
            firstName: event.firstName,
            lastName: event.lastName,
            region: event.region,
            zone: event.zone,
            woreda: event.woreda,
            profilePicPath: event.profilePicPath);

        emit(EditProfileSuccessState());
      } catch (error) {
        print(error.toString());
        emit(EditProfileFailedState());
      }
    });

    on<LoadEditProfileEvent>((event, emit) async {
      emit(EditProfileInitialState());
    });
  }
}
