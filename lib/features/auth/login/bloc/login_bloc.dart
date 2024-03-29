import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/auth/login/bloc/login_state.dart';
import 'package:wheatwise/features/auth/login/bloc/login_event.dart';
import 'package:wheatwise/features/auth/login/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository loginRepository = LoginRepository();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginButtonPressed>(onLogin);
    on<InitialEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }

  void onLogin(LoginButtonPressed event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    try {
      await loginRepository.login(event.username, event.password);
      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginFailureState(error: e.toString()));
    }
  }
}
