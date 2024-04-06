import 'package:wheatwise/features/auth/forget_password/data_provider/forget_password_data_provider.dart';

class ForgetPasswordRepository {
  ForgetPasswordDataProvider forgetPasswordDataProvider =
      ForgetPasswordDataProvider();

  Future<bool> forgetPassword(String email) async {
    try {
      bool result =
          await forgetPasswordDataProvider.forgetPassword(email: email);
      if (!result) {
        throw Exception();
      }
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
