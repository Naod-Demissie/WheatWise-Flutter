import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/auth/login/bloc/login_state.dart';
import 'package:wheatwise/features/auth/login/bloc/login_event.dart';
import 'package:wheatwise/features/auth/login/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginState> {
  final LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoadingState());
      try {
        await loginRepository.login(event.username, event.password);
        emit(LoginSuccessState());
      } catch (error) {
        print(error.toString());
        emit(LoginFailureState(error: error.toString()));
      }
    });

    on<InitialEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }
}
