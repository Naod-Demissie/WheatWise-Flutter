import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/auth_bloc/check_auth_bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/auth_bloc/check_auth_bloc/check_auth_state.dart';


class CheckAuthBloc extends Bloc<CheckAuthEvents, CheckAuthStates> {
  SharedPreferences prefs;

  CheckAuthBloc({required this.prefs}) : super(CheckAuthInitialState()) {
    on<CheckAuthEvent>(onCheckAuth);
  }

  onCheckAuth(CheckAuthEvents event, Emitter emit) async {
    emit(LoadingCheckAuthState());
    try {
      String? token = prefs.getString("token");
      String? firstName = prefs.getString("firstName");
      String? email = prefs.getString("email");
      String? password = prefs.getString("password");

      if (token != null && firstName != null && email != null && password != null) {
        emit(CheckAuthSuccessState(
            token: token, firstName: firstName, password: password, email: email));
      } else {
        throw Exception("");
      }
    } on Exception {
      emit(CheckAuthFailedState());
    }
  }
}
