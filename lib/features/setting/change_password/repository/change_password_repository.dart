import 'package:wheatwise/features/setting/change_password/data_provider/change_password_data_provider.dart';

class ChangePasswordRepository {
  ChangePasswordDataProvider changePasswordDataProvider =
      ChangePasswordDataProvider();

  Future<bool> changePassword(
      String currentPassword, String newPassword, String newPassword2) async {
    try {
      bool token = await changePasswordDataProvider.changePassword(
          currentPassword: currentPassword,
          newPassword: newPassword,
          newPassword2: newPassword);
      if (!token) {
        throw Exception();
      }
      return token;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
