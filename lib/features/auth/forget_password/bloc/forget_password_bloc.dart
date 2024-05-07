import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_event.dart';
import 'package:wheatwise/features/auth/forget_password/bloc/forget_password_state.dart';
import 'package:wheatwise/features/auth/forget_password/repository/forget_password_repository.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvents, ForgetPasswordState> {
  final ForgetPasswordRepository forgetPasswordRepository =
      ForgetPasswordRepository();

  ForgetPasswordBloc() : super(ForgetPasswordInitialState()) {
    on<ForgetPasswordEvent>((event, emit) async {
      emit(LoadingForgetPasswordState());

      try {
        await forgetPasswordRepository.forgetPassword(
          event.email,
        );
        emit(ForgetPasswordSuccessState());
      } on Exception {
        emit(ForgetPasswordFailedState());
      }
    });
    
    on<LoadForgetPasswordEvent>((event, emit) async {
      emit(ForgetPasswordInitialState());
    });
  }
}
