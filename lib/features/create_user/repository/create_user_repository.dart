// class LoginRepository {
//   LoginDataProvider loginDataProvider;
//   LoginRepository({required this.loginDataProvider});
  

//   Future<bool> register(
//       String fullname, String username, String password) async {
//     try {
//       bool token =
//           await authDataProvider.register(fullname, username, password);
//       return token;
//     } catch (e) {
//       rethrow;
//     }
//   }


// import 'package:wheatwise/features/auth/data_provider/auth_data_provider.dart';

// class AuthRepo {
//   AuthDataProvider authDataProvider;
//   AuthRepo({required this.authDataProvider});


//   Future<bool> register(
//       String fullname, String username, String password) async {
//     try {
//       bool token =
//           await authDataProvider.register(fullname, username, password);
//       return token;
//     } catch (e) {
//       rethrow;
//     }
//   }