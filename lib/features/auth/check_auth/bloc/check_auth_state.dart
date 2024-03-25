abstract class CheckAuthStates {}

class CheckAuthInitialState extends CheckAuthStates {}

class LoadingCheckAuthState extends CheckAuthStates {}

class CheckAuthSuccessState extends CheckAuthStates {
  String token;
  String firstName;
  String email;
  String password;

  CheckAuthSuccessState({
    required this.token,
    required this.firstName,
    required this.email,
    required this.password,
  });
}

class CheckAuthFailedState extends CheckAuthStates {}
