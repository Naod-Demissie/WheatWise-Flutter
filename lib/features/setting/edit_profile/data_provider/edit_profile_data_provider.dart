import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileDataProvider {
  final String? _baseUrl = dotenv.env["API_URL"];
  Dio dio = Dio();

  Future<bool> editProfile({
    required String username,
    required String prefix,
    required String firstName,
    required String lastName,
    required String region,
    required String zone,
    required String woreda,
    required String profilePicPath,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? email = prefs.getString('email');
      String? organization = prefs.getString('organization');
      String? sex = prefs.getString('sex');
      String? role = prefs.getString('role');
      // String? profilePicPath = prefs.getString('profilePicPath');

      if (token == null) {
        throw Exception("Not logged in");
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      File imageFile = File(profilePicPath);
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      Response response =
          await dio.put('$_baseUrl/users/update-profile', data: {
        "username": username,
        "prefix": prefix,
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "sex": sex,
        "role": role,
        "region": region,
        "zone": zone,
        "woreda": woreda,
        "organization": organization,
        "profile_pic_base64": base64Image
      });

      if (response.statusCode != 200) {
        throw (Exception('Failed to edit profile'));
      }

      await prefs.setString("username", username);
      await prefs.setString("prefix", prefix);
      await prefs.setString("firstName", firstName);
      await prefs.setString("lastName", lastName);
      await prefs.setString("region", region);
      await prefs.setString("zone", zone);
      await prefs.setString("woreda", woreda);
      await prefs.setString("profilePicPath", profilePicPath);

      return true;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}
