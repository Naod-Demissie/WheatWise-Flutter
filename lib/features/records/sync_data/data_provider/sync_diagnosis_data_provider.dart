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

      print(1111111111);
      print(mobileDiagnosisInput);

      if (diagnosis.isUploaded == null) {
        print(22222222);

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
        print('response');
        print(response);
        print('diagnosis');
        print(diagnosis);
        return diagnosis;
      } else {
        print(555555555555);

        dio.options.headers['Authorization'] = 'Bearer $token';
        final response = await dio.put(
          '$_baseUrl/diagnosis/update-mobile-diagnosis',
          // data: formData,
          data: mobileDiagnosisInput,
          onSendProgress: (count, total) {},
        );
        print('response');
        print(response);
        print('diagnosis');
        print(diagnosis);

        return diagnosis;
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        throw ImageNotLeaf("image provided is not leaf");
      } else {
        rethrow;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi));
  }
}
// class SyncDiagnosisDataProvider {
//   final String _baseUrl = dotenv.env["API_URL"]!;
//   final Dio dio = Dio();

//   SyncDiagnosisDataProvider();

//   Future<Diagnosis> syncDiagnosis(
//     Diagnosis diagnosis,
//   ) async {
//     try {
//       bool internetConnectionAvailable = await checkInternetConnection();
//       if (!internetConnectionAvailable) {
//         throw NoInternet(message: "Upload interrupted: Connection lost.");
//       }
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception("Not logged in");
//       }
//       print(1111111111);
//       print(diagnosis.isUploaded);

//       if (diagnosis.isUploaded == null) {
//         print(22222222);
//         FormData formData = FormData.fromMap({
//           'file': await MultipartFile.fromFile(
//             diagnosis.filePath,
//             filename: diagnosis.fileName,
//           ),
//           'mobile_diagnosis_input': jsonEncode({
//             "mobile_id": diagnosis.mobileId,
//             "mobile_diagnosis": diagnosis.mobileDiagnosis,
//             "manual_diagnosis": diagnosis.manualDiagnosis ?? '',
//             "mobile_image_path": diagnosis.filePath,
//             "remark": "",
//             "file_name": diagnosis.fileName,
//             "mobile_confidence_score": diagnosis.confidenceScore,
//           })
//         });
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         Response response = await dio.post(
//           '$_baseUrl/diagnosis/upload-mobile-diagnosis',
//           data: formData,
//           onSendProgress: (count, total) {},
//         );

//         diagnosis.serverId = response.data['server_id'];
//         // diagnosis.uploadTime = DateTime.now().microsecondsSinceEpoch;
//         diagnosis.isUploaded = true;
//         print(diagnosis);
//         return diagnosis;
//       } else {
//         print(555555555555);
//         // FormData formData = FormData.fromMap({
//         //   'mobile_diagnosis_input': {
//         //     "mobile_id": diagnosis.mobileId,
//         //     "mobile_diagnosis": diagnosis.mobileDiagnosis,
//         //     "manual_diagnosis": diagnosis.manualDiagnosis,
//         //     "mobile_image_path": diagnosis.filePath,
//         //     "remark": "",
//         //     "file_name": diagnosis.fileName,
//         //     "mobile_confidence_score": diagnosis.confidenceScore,
//         //   }
//         // });
//         // FormData formData = FormData.fromMap({
//         //   "mobile_id": diagnosis.mobileId,
//         //   "mobile_diagnosis": diagnosis.mobileDiagnosis,
//         //   "manual_diagnosis": diagnosis.manualDiagnosis,
//         //   "mobile_image_path": diagnosis.filePath,
//         //   "remark": "",
//         //   "file_name": diagnosis.fileName,
//         //   "mobile_confidence_score": diagnosis.confidenceScore,
//         // });
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         await dio.put(
//           '$_baseUrl/diagnosis/update-mobile-diagnosis',
//           // data: formData,
//           data: {
//             "mobile_id": diagnosis.mobileId,
//             "mobile_diagnosis": diagnosis.mobileDiagnosis,
//             "manual_diagnosis": diagnosis.manualDiagnosis,
//             "mobile_image_path": diagnosis.filePath,
//             "remark": "",
//             "file_name": diagnosis.fileName,
//             "mobile_confidence_score": diagnosis.confidenceScore,
//           },
//           onSendProgress: (count, total) {},
//         );
//         print(diagnosis);

//         return diagnosis;
//       }
//     } on DioException catch (e) {
//       if (e.response != null && e.response!.statusCode == 400) {
//         throw ImageNotLeaf("image provided is not leaf");
//       } else {
//         rethrow;
//       }
//     } catch (e) {
//       print(e.toString());
//       rethrow;
//     }
//   }

//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi));
//   }
// }
// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:wheatwise/features/records/file_upload/exceptions/upload_exceptions.dart';
// import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

// class SyncDiagnosisDataProvider {
//   final String _baseUrl = dotenv.env["API_URL"]!;
//   final Dio dio = Dio();

//   SyncDiagnosisDataProvider();

//   Future<Diagnosis> syncDiagnosis(
//     Diagnosis diagnosis,
//   ) async {
//     try {
//       bool internetConnectionAvailable = await checkInternetConnection();
//       if (!internetConnectionAvailable) {
//         throw NoInternet(message: "Upload interrupted: Connection lost.");
//       }
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? token = prefs.getString('token');
//       if (token == null) {
//         throw Exception("Not logged in");
//       }

//       FormData formData = FormData.fromMap({
//         'file': await MultipartFile.fromFile(
//           diagnosis.filePath,
//           filename: diagnosis.fileName,
//         ),
//         'mobile_diagnosis_input': jsonEncode({
//           "mobile_id": diagnosis.mobileId,
//           "mobile_diagnosis": diagnosis.mobileDiagnosis,
//           "manual_diagnosis": diagnosis.manualDiagnosis,
//           "mobile_image_path": diagnosis.filePath,
//           "remark": "",
//           "file_name": diagnosis.fileName,
//           "mobile_confidence_score": diagnosis.confidenceScore,
//         })
//       });
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       Response response = await dio.post(
//         '$_baseUrl/diagnosis/upload-mobile-diagnosis',
//         data: formData,
//         onSendProgress: (count, total) {},
//       );


//       diagnosis.serverId = response.data['server_id'];
//       // diagnosis.uploadTime = DateTime.now().microsecondsSinceEpoch;
//       diagnosis.isUploaded = true;
//       return diagnosis;
//     } on DioException catch (e) {
//       if (e.response != null && e.response!.statusCode == 400) {
//         throw ImageNotLeaf("image provided is not leaf");
//       } else {
//         rethrow;
//       }
//     } catch (e) {
//       print(e.toString());
//       rethrow;
//     }
//   }

//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi));
//   }
// }
