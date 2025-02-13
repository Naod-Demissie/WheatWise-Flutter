import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_event.dart';
import 'package:wheatwise/features/auth/check_auth/bloc/check_auth_state.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvent, CheckAuthState> {
  final SharedPreferences prefs;

  CheckAuthBloc({required this.prefs}) : super(CheckAuthInitialState()) {
    on<CheckAuthEvent>((event, emit) async {
      emit(LoadingCheckAuthState());
      try {
        String? token = prefs.getString("token");
        String? firstName = prefs.getString("firstName");
        String? email = prefs.getString("email");
        String? password = prefs.getString("password");

        if (token != null &&
            firstName != null &&
            email != null &&
            password != null) {
          emit(CheckAuthSuccessState(
            token: token,
            firstName: firstName,
            email: email,
            password: password,
          ));
        } else {
          throw Exception("Missing credentials in SharedPreferences");
        }
      } catch (error) {
        print(error.toString());
        emit(CheckAuthFailedState());
      }
    });
  }
}
