import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class SyncDiagnosisDataProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  final Dio dio = Dio();

  SyncDiagnosisDataProvider();

  Future<Diagnosis> syncDiagnosis(
    Diagnosis diagnosis,
  ) async {
    try {
      bool internetConnectionAvailable = await checkInternetConnection();
      if (!internetConnectionAvailable) {
        throw NoInternet(message: "Upload interrupted: Connection lost.");
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("Not logged in");
      }

      Map<String, dynamic> mobileDiagnosisInput = {
        "mobile_id": diagnosis.mobileId,
        "mobile_diagnosis": diagnosis.mobileDiagnosis,
        "mobile_image_path": diagnosis.filePath,
        "remark": "",
        "file_name": diagnosis.fileName,
        "mobile_confidence_score": diagnosis.confidenceScore,
      };

      if (diagnosis.manualDiagnosis != '') {
        mobileDiagnosisInput['manual_diagnosis'] = diagnosis.manualDiagnosis;
      }

      if (diagnosis.isUploaded == false) {
        FormData formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            diagnosis.filePath,
            filename: diagnosis.fileName,
          ),
          'mobile_diagnosis_input': jsonEncode(mobileDiagnosisInput)
        });
        dio.options.headers['Authorization'] = 'Bearer $token';
        Response response = await dio.post(
          '$_baseUrl/diagnosis/upload-mobile-diagnosis',
          data: formData,
          onSendProgress: (count, total) {},
        );

        diagnosis.serverId = response.data['server_id'];
        // diagnosis.uploadTime = DateTime.now().microsecondsSinceEpoch;
        diagnosis.isUploaded = true;
        return diagnosis;
      } else {
        dio.options.headers['Authorization'] = 'Bearer $token';
        await dio.put(
          '$_baseUrl/diagnosis/update-mobile-diagnosis',
          // data: formData,
          data: mobileDiagnosisInput,
          onSendProgress: (count, total) {},
        );
        return diagnosis;
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw ImageNotLeaf("image provided is not leaf");
      } else {
        rethrow;
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }
}
