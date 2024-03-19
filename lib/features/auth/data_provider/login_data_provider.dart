import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDataProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  final Dio dio;

  LoginDataProvider({required this.dio});

  Future<void> saveDataLocally({
    required String token,
    required String firstName, //! check what else is neccesary
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

      final response = await dio.post('$_baseUrl/auth/login/', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to login');
      }

      final token = response.data['access_token'];
      dio.options.headers['Authorization'] = 'Bearer $token';

      final getUser = await dio.get('$_baseUrl/account/');

      if (getUser.statusCode != 200) {
        throw Exception('Failed to fetch user data');
      }

      final firstName = getUser.data['result']['firstName'];
      await saveDataLocally(
        token: token,
        email: username,
        password: password,
        firstName: firstName,
      );
      return token;
    } catch (e) {
      // print({"error": e});
      rethrow;
    }
  }
}
