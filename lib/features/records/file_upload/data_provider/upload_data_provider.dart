import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class UploadDataProvider {
  final String _baseUrl = dotenv.env["API_URL"]!;
  final Dio dio = Dio();

  UploadDataProvider();

  Future<Diagnosis> uploadLeaf(
    String fileName,
    int uploadTime,
    String filePath,
    bool isServerDiagnosed,
  ) async {
    try {
      bool internetConnectionAvailable = await checkInternetConnection();
      if (!internetConnectionAvailable) {
        throw NoInternet(message: "connection error while uploading");
      }

      // await checkLeaf(leaf, imageChecker);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("Not logged in");
      }

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response response = await dio.post(
        '$_baseUrl/diagnosis/diagnose-on-upload',
        data: formData,
        onSendProgress: (count, total) {},
      );

      String originalLeafImage =
          await copyImageToAppData(filePath, fileName, '');

      Diagnosis responseLeaf = Diagnosis(
        mobileId: const Uuid().v4(),
        serverId: response.data['diagnosis_id'],
        fileName: fileName,
        filePath: originalLeafImage,
        uploadTime: uploadTime,
        modelDiagnosis: response.data['server_diagnosis'],
        manualDiagnosis: '',
        isBookmarked: false,
        isServerDiagnosed: isServerDiagnosed,
        confidenceScore: (response.data['confidence_score'] as List<dynamic>)
            .map<double>((e) => e.toDouble())
            .toList(),
      );
      return responseLeaf;
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw ImageNotLeaf("image provided is not leaf");
      } else {
        rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> copyImageToAppData(
      String sourcePath, String name, String s) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String destinationPath = path.join(appDir.path, '$s$name');

    File sourceFile = File(sourcePath);
    await sourceFile.copy(destinationPath);

    return destinationPath;
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }
}
