import 'package:wheatwise/features/auth/login/data_provider/login_data_provider.dart';

class LoginRepository {
  final LoginDataProvider loginDataProvider = LoginDataProvider();

  Future<String> login(String username, String password) async {
    try {
      String token = await loginDataProvider.login(username, password);
      return token;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
