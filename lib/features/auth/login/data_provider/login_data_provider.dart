import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  final Dio dio = Dio();

  LoginDataProvider();

  Future<void> saveDataLocally({
    required String token,
    required String firstName,
    required String email,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('firstName', firstName);
    await prefs.setString('email', email);
    await prefs.setString(
        'password', BCrypt.hashpw(password, BCrypt.gensalt()));
  }

  Future<String> login(String username, String password) async {
    try {
      dio.options.headers['content-Type'] = 'application/json';
      FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
        'grant_type': '',
        'scope': '',
        'client_id': '',
        'client_secret': '',
      });

      final response = await dio.post('$_baseUrl/auth/login', data: formData);

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      final token = response.data['access_token'];
      dio.options.headers['Authorization'] = 'Bearer $token';

      final getUser = await dio.get('$_baseUrl/users/get-user');

      if (getUser.statusCode != 200) {
        throw Exception('Failed to fetch user data');
      }
      await saveDataLocally(
        token: token,
        email: getUser.data['email'],
        firstName: getUser.data['firstname'],
        password: password,
      );
      return token;
    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }
}
