import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_event.dart';
import 'package:wheatwise/features/auth/logout/bloc/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutStates> {
  LogoutBloc() : super(LogoutInitialState()) {
    on<LogoutButtonPressed>((event, emit) async {
      emit(LogoutLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool cleared = await prefs.clear();
        if (!cleared) throw Exception();
        emit(LogoutSuccessState());
      } catch (error) {
        print(error.toString());
        emit(LogoutFailureState(error: error.toString()));
      }
    });
  }
}
