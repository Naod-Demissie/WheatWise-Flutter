import 'dart:io';
import 'package:uuid/uuid.dart';

import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheatwise/features/file_upload/exceptions/upload_exceptions.dart';
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
        throw Exception("Not Logged In");
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
      dynamic jsonResponse = response.data;

      String originalLeafImage =
          await copyImageToAppData(filePath, fileName, '');

      Diagnosis responseLeaf = Diagnosis(
        mobileId: const Uuid().v4(),
        serverId: jsonResponse['diagnosis_id'],
        fileName: fileName,
        filePath: originalLeafImage,
        uploadTime: uploadTime,
        modelDiagnosis: jsonResponse['server_diagnosis'],
        manualDiagnosis: '',
        isBookmarked: false,
        isServerDiagnosed: isServerDiagnosed,
        confidenceScore: (jsonResponse['confidence_score'] as List<dynamic>)
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

// class UploadDataProvider {
//   final String _baseUrl = dotenv.env["API_URL"]!;
//   final Dio dio = Dio();

//   UploadDataProvider();

//   Future<Diagnosis> uploadLeaf(
//     String fileName,
//     int uploadTime,
//     String filePath,
//     bool isServerDiagnosed,
//   ) async {
//     try {
//       bool internetConnectionAvailable = await checkInternetConnection();
//       if (!internetConnectionAvailable) {
//         throw NoInternet(message: "connection error while uploading");
//       }

//       // await checkLeaf(leaf, imageChecker);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception("Not Logged In");
//       }

//       FormData formData = FormData.fromMap({
//         'image': await MultipartFile.fromFile(filePath),
//         'fileName': fileName,
//         'isServerDiagnosed': isServerDiagnosed ? "True" : "False",
//       });

//       dio.options.headers['content-Type'] = 'application/json';
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       Response response = await dio.post(
//         '$_baseUrl/diagnosis/diagnose-on-upload',
//         data: formData,
//         onSendProgress: (count, total) {},
//       );

//       /* to get json formatted data if response is 2-- and create detected leaf object*/
//       dynamic jsonResponse = response.data;

//       String originalLeafImage =
//           await copyImageToAppData(filePath, fileName, '');

//       List<String> lst = [];
//       for (var disease in jsonResponse['diseases']) {
//         lst.add(disease.toString());
//       }

//       Diagnosis responseLeaf = Diagnosis(
//         mobileId: const Uuid().v4(),
//         serverId: jsonResponse['id'],
//         fileName: fileName,
//         filePath: originalLeafImage,
//         uploadTime: uploadTime,
//         modelDiagnosis: jsonResponse['diseases'],
//         manualDiagnosis: '',
//         isBookmarked: false,
//         isServerDiagnosed: isServerDiagnosed,
//         confidenceScore: jsonResponse['confidenceScore'],
//       );

//       return responseLeaf;
//     } on DioException catch (e) {
//       if (e.response != null && e.response!.statusCode == 400) {
//         throw ImageNotLeaf("image provided is not leaf");
//       } else {
//         rethrow;
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<String> copyImageToAppData(
//       String sourcePath, String name, String s) async {
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String destinationPath = path.join(appDir.path, '$s$name');

//     File sourceFile = File(sourcePath);
//     await sourceFile.copy(destinationPath);

//     return destinationPath;
//   }

//   Future<String> downloadAndSaveImage(String imageUrl, String name) async {
//     try {
//       Directory appDir = await getApplicationDocumentsDirectory();
//       String savePath = path.join(appDir.path, name);

//       final response = await dio.get(imageUrl);

//       if (response.statusCode != 200) {
//         throw (Exception('Failed to login'));
//       }
//       final imageByte = response.data["result"]["image"];
//       // print({
//       //   "image": [imageByte.runtimeType, imageByte]
//       // });

//       // // final bytes = response.data as Uint8List;
//       // Uint8List imageUint8List = Uint8List.fromList(imageByte.codeUnits);
//       Uint8List bytes = base64Decode(imageByte.replaceAll(RegExp(r'\s+'), ''));

//       final file = File(savePath);
//       await file.writeAsBytes(bytes);
//       // await dio.download(imageUrl, savePath).timeout(const Duration(minutes: 2));

//       return savePath;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // Future<bool> checkLeaf(String filePath, ImageChecker imageChecker) async {
//   //   File imageFile = File(filePath);
//   //   List<dynamic> inputTensor = await imageChecker.imageToTensor(imageFile);
//   //   bool isImageLeaf = await imageChecker.runInference(inputTensor);
//   //   if (!isImageLeaf) throw ImageNotLeaf("image is not leaf");
//   //   return isImageLeaf;
//   // }

//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi)) {
//       // Internet connection available
//       return true;
//     } else {
//       // No internet connection
//       return false;
//     }
//   }
// }
