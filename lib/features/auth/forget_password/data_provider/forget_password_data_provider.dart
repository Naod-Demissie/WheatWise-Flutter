import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ForgetPasswordDataProvider {
  final String? _baseUrl = dotenv.env["API_URL"];
  Dio dio = Dio();

  Future<bool> forgetPassword({
    required String email,
  }) async {
    try {
      Response response = await dio.put(
          '$_baseUrl/users/request-password-reset?email=${email.split('@').join('%40')}');

      if (response.statusCode != 200) {
        throw (Exception('Failed to reset password'));
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }
}
