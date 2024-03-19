import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthDataProvider {
  final String? _baseUrl = dotenv.env["API_URL"];
  Dio dio;
  AuthDataProvider({required this.dio});



  Future<bool> changePassword({required String newPassword}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("notLogged In");
      }

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio
          .post('$_baseUrl/account/update-password/', data: <String, String>{
        'password': newPassword,
      });

      if (response.statusCode != 200) {
        throw (Exception('Failed to register'));
      }

      bool changed = await prefs.setString(
          'password', BCrypt.hashpw(newPassword, BCrypt.gensalt()));

      return changed;
    } catch (e) {
      rethrow;
    }
  }
}