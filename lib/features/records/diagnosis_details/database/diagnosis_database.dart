import 'package:hive/hive.dart';

part 'diagnosis_database.g.dart';

/// run this on terminal to generate diagnosis_database.g.dart file
/// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Diagnosis extends HiveObject {
  @HiveField(0)
  late String mobileId;

  @HiveField(1)
  late String? serverId;

  @HiveField(2)
  late String fileName;

  @HiveField(3)
  late String filePath;

  @HiveField(4)
  late int uploadTime;

  @HiveField(5)
  late String modelDiagnosis;

  @HiveField(6)
  late String? manualDiagnosis;

  @HiveField(7)
  late bool? isBookmarked;

  @HiveField(8)
  late bool? isServerDiagnosed;

  @HiveField(9)
  late List<double> confidenceScore;

  Diagnosis({
    required this.mobileId,
    this.serverId,
    required this.fileName,
    required this.filePath,
    required this.uploadTime,
    required this.modelDiagnosis,
    this.manualDiagnosis,
    this.isBookmarked,
    this.isServerDiagnosed,
    required this.confidenceScore,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) {
    return Diagnosis(
      mobileId: json['mobileId'] ?? '',
      serverId: json['serverId'] ?? '',
      fileName: json['fileName'] ?? '',
      filePath: json['filePath'] ?? '',
      uploadTime: json['uploadTime'] ?? 0,
      modelDiagnosis: json['modelDiagnosis'] ?? '',
      manualDiagnosis: json['manualDiagnosis'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
      isServerDiagnosed: json['isServerDiagnosed'] ?? false,
      confidenceScore: List<double>.from(json['confidenceScore'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['mobileId'] = mobileId;
    json['serverId'] = serverId;
    json['fileName'] = fileName;
    json['filePath'] = filePath;
    json['uploadTime'] = uploadTime;
    json['modelDiagnosis'] = modelDiagnosis;
    json['manualDiagnosis'] = manualDiagnosis;
    json['isBookmarked'] = isBookmarked;
    json['isServerDiagnosed'] = isServerDiagnosed;
    json['confidenceScore'] = confidenceScore;
    return json;
  }

  @override
  String toString() {
    return "fileName $fileName, manualDiagnosis ${manualDiagnosis}, modelDiagnosis $modelDiagnosis,  isBookmarked: $isBookmarked, isServerDiagnosed: $isServerDiagnosed, mobileId: $mobileId, serverId: $serverId";
  }
}
// import 'package:hive/hive.dart';

// part 'diagnosis_database.g.dart';

// /// run this on terminal to generate diagnosis_database.g.dart file
// /// flutter packages pub run build_runner build

// @HiveType(typeId: 0)
// class Diagnosis extends HiveObject {
//   @HiveField(0)
//   late String mobileId;

//   @HiveField(1)
//   late String serverId;

//   @HiveField(2)
//   late String fileName;

//   @HiveField(3)
//   late String filePath;

//   @HiveField(4)
//   late int uploadTime;

//   @HiveField(5)
//   late String modelDiagnosis;

//   @HiveField(6)
//   late String? manualDiagnosis;

//   @HiveField(7)
//   late bool? isBookmarked;

//   @HiveField(8)
//   late bool? isServerDiagnosed;

//   @HiveField(9)
//   late List<double> confidenceScore;

//   Diagnosis({
//     required this.mobileId,
//     this.serverId = "",
//     required this.fileName,
//     required this.filePath,
//     required this.uploadTime,
//     required this.modelDiagnosis,
//     this.manualDiagnosis,
//     this.isBookmarked,
//     this.isServerDiagnosed,
//     required this.confidenceScore,
//   });

//   factory Diagnosis.fromJson(Map<String, dynamic> json) {
//     return Diagnosis(
//       mobileId: json['mobileId'] ?? '',
//       serverId: json['serverId'] ?? '',
//       fileName: json['fileName'] ?? '',
//       filePath: json['filePath'] ?? '',
//       uploadTime: json['uploadTime'] ?? 0,
//       modelDiagnosis: json['modelDiagnosis'] ?? '',
//       manualDiagnosis: json['manualDiagnosis'] ?? '',
//       isBookmarked: json['isBookmarked'] ?? false,
//       isServerDiagnosed: json['isServerDiagnosed'] ?? false,
//       confidenceScore: List<double>.from(json['confidenceScore'] ?? []),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> json = {};
//     json['mobileId'] = mobileId;
//     json['serverId'] = serverId;
//     json['fileName'] = fileName;
//     json['filePath'] = filePath;
//     json['uploadTime'] = uploadTime;
//     json['modelDiagnosis'] = modelDiagnosis;
//     json['manualDiagnosis'] = manualDiagnosis;
//     json['isBookmarked'] = isBookmarked;
//     json['isServerDiagnosed'] = isServerDiagnosed;
//     json['confidenceScore'] = confidenceScore;
//     return json;
//   }

//   @override
//   String toString() {
//     return "fileName $fileName, modelDiagnosis ${modelDiagnosis} isBookmarked: $isBookmarked, isServerDiagnosed: $isServerDiagnosed, mobileId: $mobileId";
//   }
// }
