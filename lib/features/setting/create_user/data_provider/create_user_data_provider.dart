

// class AuthDataProvider {
//   final String? _baseUrl = dotenv.env["API_URL"];
//   Dio dio;
//   AuthDataProvider({required this.dio});

//   Future<bool> register(
//       String fullname, String username, String password) async {
//     try {
//       dio.options.headers = {};
//       dio.options.headers['content-Type'] = 'application/json';
//       final response = await dio.post('$_baseUrl/account/add-new/',
//           data: <String, String>{
//             'fullname': fullname,
//             'email': username,
//             'password': password
//           });
//       if (response.statusCode != 200) {
//         throw (Exception('Failed to register'));
//       }
//       return true;
//     } catch (e) {
//       print({"error": e});
//       rethrow;
//     }
//   }