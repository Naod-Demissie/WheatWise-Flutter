import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheatwise/features/auth/auth_bloc/login_bloc/login_state.dart';
import 'package:wheatwise/features/auth/auth_bloc/login_bloc/login_event.dart';
import 'package:wheatwise/features/auth/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitialState()) {
    on<LoginButtonPressed>(onLogin);
    on<InitialEvent>((event, emit) {
      emit(LoginInitialState());
    });
  }

  void onLogin(LoginButtonPressed event, Emitter<LoginStates> emit) async {
    emit(LoginLoadingState());
    try {
      String accessToken =
          await loginRepository.login(event.username, event.password);
      emit(LoginSuccessState());
    } catch (e) {
      // Catch any type of error
      emit(LoginFailureState(error: e.toString()));
    }
  }
}
