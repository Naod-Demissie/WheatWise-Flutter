import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_event.dart';
import 'package:wheatwise/features/setting/change_password/bloc/change_password_state.dart';
import 'package:wheatwise/features/setting/change_password/repository/change_password_repository.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvents, ChangePasswordState> {
  final ChangePasswordRepository changePasswordRepository =
      ChangePasswordRepository();

  ChangePasswordBloc() : super(ChangePasswordInitialState()) {
    on<ChangePasswordEvent>((event, emit) async {
      emit(LoadingChangePasswordState());
      try {
        await changePasswordRepository.changePassword(
          event.currentPassword,
          event.newPassword,
          event.newPassword2,
        );
        emit(ChangePasswordSuccessState());
      } on Exception {
        emit(ChangePasswordFailedState());
      }
    });

    on<LoadChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordInitialState());
    });
  }
}
