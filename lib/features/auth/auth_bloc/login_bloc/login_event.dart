abstract class LoginEvents {}

class LoginButtonPressed extends LoginEvents {
  final String username;
  final String password;

  LoginButtonPressed({required this.username, required this.password});
}

class InitialEvent extends LoginEvents {
  InitialEvent();
}