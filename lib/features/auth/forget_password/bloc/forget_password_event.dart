abstract class ForgetPasswordEvents {}

class ForgetPasswordEvent extends ForgetPasswordEvents {
  String email;
  ForgetPasswordEvent({
    required this.email,
  });
}

class LoadForgetPasswordEvent extends ForgetPasswordEvents {
  LoadForgetPasswordEvent();
}
