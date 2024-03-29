import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordDataProvider {
  final String? _baseUrl = dotenv.env["API_URL"];
  Dio dio = Dio();

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String newPassword2,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? email = prefs.getString('email');

      if (token == null) {
        throw Exception("Not logged in");
      }

      Response response =
          await dio.post('$_baseUrl/users/update-password', data: {
        "email": email,
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password2": newPassword2,
      });

      if (response.statusCode != 200) {
        throw (Exception('Failed to change password'));
      }

      bool changed = await prefs.setString(
          'password', BCrypt.hashpw(newPassword, BCrypt.gensalt()));

      return changed;
    } catch (e) {
      rethrow;
    }
  }
}
