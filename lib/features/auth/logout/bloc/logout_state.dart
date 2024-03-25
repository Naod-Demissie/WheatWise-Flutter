abstract class LogoutStates {}

class LogoutInitialState extends LogoutStates {}

class LogoutLoadingState extends LogoutStates {}

class LogoutSuccessState extends LogoutStates {}

class LogoutFailureState extends LogoutStates {
  final String error;

  LogoutFailureState({required this.error});
}
