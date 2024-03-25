// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ChangePasswordEvents {}

class ChangePasswordEvent extends ChangePasswordEvents {
  String currentPassword;
  String newPassword;
  String newPassword2;
  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.newPassword2,
  });
}

class LoadChangePasswordEvent extends ChangePasswordEvents {
  LoadChangePasswordEvent();
}
