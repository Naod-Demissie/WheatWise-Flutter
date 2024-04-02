abstract class CheckAuthState {}

class CheckAuthInitialState extends CheckAuthState {}

class LoadingCheckAuthState extends CheckAuthState {}

class CheckAuthSuccessState extends CheckAuthState {
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

class CheckAuthFailedState extends CheckAuthState {}
