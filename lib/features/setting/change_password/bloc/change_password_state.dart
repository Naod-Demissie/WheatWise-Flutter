abstract class ChangePasswordStates {}

class ChangePasswordInitialState extends ChangePasswordStates {}

class LoadingChangePasswordState extends ChangePasswordStates {}

class ChangePasswordSuccessState extends ChangePasswordStates {}

class ChangePasswordFailedState extends ChangePasswordStates {}
