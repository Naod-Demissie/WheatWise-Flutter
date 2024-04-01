import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';

class ManualDiagnosisProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  Dio dio = Dio();
  ManualDiagnosisProvider();

  Future<String> updateManualDiagnosis(
    String serverId,
    String manualDiagnosis,
  ) async {
    try {
      bool internetConnectionAvailable = await checkInternetConnection();
      if (!internetConnectionAvailable) {
        throw NoInternet(message: "connection error while uploading");
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("Not logged in");
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.put(
        '$_baseUrl/diagnosis/update-manual-diagnosis?diagnosis_id=$serverId&manual_diagnosis=${manualDiagnosis.split(' ').join('%20')}',
      );

      if (response.statusCode != 200) {
        throw (Exception('Failed to login'));
      }

      return 'successfully updated manual diagnosis';
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }
}
