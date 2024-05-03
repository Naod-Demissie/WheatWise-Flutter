import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class LoginDataProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  final Dio dio = Dio();

  LoginDataProvider();

  Future<void> saveDataLocally({
    required String token,
    required String username,
    required String prefix,
    required String firstName,
    required String lastName,
    required String email,
    required String sex,
    required String role,
    required String region,
    required String zone,
    required String woreda,
    required String organization,
    // required String firstTimeLogin,
    required String createdAt,
    required String profilePicPath,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
    await prefs.setString('username', username);
    await prefs.setString('prefix', prefix);
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('sex', sex);
    await prefs.setString('role', role);
    await prefs.setString('region', region);
    await prefs.setString('zone', zone);
    await prefs.setString('woreda', woreda);
    await prefs.setString('organization', organization);
    // await prefs.setString('firstTimeLogin', firstTimeLogin.toString());
    await prefs.setString('createdAt', createdAt);
    await prefs.setString('profilePicPath', profilePicPath);
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

      print('getUser: $getUser');

      if (getUser.statusCode != 200) {
        throw Exception('Failed to fetch user data');
      }

      List<int> imageBytes = base64.decode(getUser.data['profile_pic_base64']);

      String fileName = '${getUser.data['user_id']}.jpg';
      // String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.png';
      // String dir = (await getApplicationDocumentsDirectory()).path;
      String profilePicPath =
          '/data/user/0/com.example.wheatwise/cache/$fileName';
      // String profilePicPath = '$dir/$fileName';

      // Write the bytes to a file
      // File file = File(profilePicPath);
      File file = File(profilePicPath);
      await file.writeAsBytes(imageBytes);

      await saveDataLocally(
        token: token,
        username: getUser.data['username'],
        prefix: getUser.data['prefix'],
        firstName: getUser.data['firstname'],
        lastName: getUser.data['lastname'],
        email: getUser.data['email'],
        sex: getUser.data['sex'],
        role: getUser.data['role'],
        region: getUser.data['region'],
        zone: getUser.data['zone'],
        woreda: getUser.data['woreda'],
        organization: getUser.data['organization'],
        // firstTimeLogin: getUser.data['first_time_login'],
        createdAt: getUser.data['created_at'],
        profilePicPath: profilePicPath,
        password: password,
      );
      return token;
    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }
}



// import 'package:bcrypt/bcrypt.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginDataProvider {
//   final String _baseUrl = dotenv.env["API_URL"]!;
//   final Dio dio = Dio();

//   LoginDataProvider();

//   Future<String> login(String username, String password) async {
//     try {
//       dio.options.headers['content-Type'] = 'application/json';
//       FormData formData = FormData.fromMap({
//         'username': username,
//         'password': password,
//         'grant_type': '',
//         'scope': '',
//         'client_id': '',
//         'client_secret': '',
//       });

//       final response = await dio.post('$_baseUrl/auth/login', data: formData);

//       if (response.statusCode != 200) {
//         throw Exception('Failed to login');
//       }

//       final token = response.data['access_token'];
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final getUser = await dio.get('$_baseUrl/users/get-user');

//       if (getUser.statusCode != 200) {
//         throw Exception('Failed to fetch user data');
//       }

//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('token', token);
//       await prefs.setString('username', getUser.data['username']);
//       await prefs.setString('prefix', getUser.data['prefix']);
//       await prefs.setString('firstname', getUser.data['firstname']);
//       await prefs.setString('lastname', getUser.data['lastname']);
//       await prefs.setString('email', getUser.data['email']);
//       await prefs.setString('sex', getUser.data['sex']);
//       await prefs.setString('role', getUser.data['role']);
//       await prefs.setString('region', getUser.data['region']);
//       await prefs.setString('zone', getUser.data['zone']);
//       await prefs.setString('woreda', getUser.data['woreda']);
//       await prefs.setString('organization', getUser.data['organization']);
//       await prefs.setString(
//           'first_time_login', getUser.data['first_time_login']);
//       await prefs.setString('created_at', getUser.data['created_at']);
//       await prefs.setString(
//           'password', BCrypt.hashpw(password, BCrypt.gensalt()));

//       return token;
//     } catch (e) {
//       print({"error": e});
//       rethrow;
//     }
//   }
// }


// import 'package:bcrypt/bcrypt.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginDataProvider {
//   final String _baseUrl = dotenv.env["API_URL"]!;
//   final Dio dio = Dio();

//   LoginDataProvider();

//   Future<void> saveDataLocally({
//     required String token,
//     required String firstName,
//     required String email,
//     required String password,
//   }) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//     await prefs.setString('firstName', firstName);
//     await prefs.setString('email', email);
//     await prefs.setString(
//         'password', BCrypt.hashpw(password, BCrypt.gensalt()));
//   }

//   Future<String> login(String username, String password) async {
//     try {
//       dio.options.headers['content-Type'] = 'application/json';
//       FormData formData = FormData.fromMap({
//         'username': username,
//         'password': password,
//         'grant_type': '',
//         'scope': '',
//         'client_id': '',
//         'client_secret': '',
//       });

//       final response = await dio.post('$_baseUrl/auth/login', data: formData);

//       if (response.statusCode != 200) {
//         throw Exception('Failed to login');
//       }

//       final token = response.data['access_token'];
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final getUser = await dio.get('$_baseUrl/users/get-user');

//       if (getUser.statusCode != 200) {
//         throw Exception('Failed to fetch user data');
//       }
//       await saveDataLocally(
//         token: token,
//         email: getUser.data['email'],
//         firstName: getUser.data['firstname'],
//         password: password,
//       );
//       return token;
//     } catch (e) {
//       print({"error": e});
//       rethrow;
//     }
//   }
// }
