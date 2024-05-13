// import 'package:hive/hive.dart';

// part 'diagnosis_database.g.dart';

// /// run this on terminal to generate diagnosis_database.g.dart file
// /// flutter packages pub run build_runner build

// @HiveType(typeId: 0)
// class Diagnosis extends HiveObject {
//   @HiveField(0)
//   String mobileId;

//   @HiveField(1)
//   String? serverId;

//   @HiveField(2)
//   String fileName;

//   @HiveField(3)
//   String filePath;

//   @HiveField(4)
//   int uploadTime;

//   @HiveField(5)
//   String mobileDiagnosis;

//   @HiveField(6)
//   String? serverDiagnosis;

//   @HiveField(7)
//   String? manualDiagnosis;

//   @HiveField(8, defaultValue: false)
//   bool? isBookmarked;

//   @HiveField(9, defaultValue: false)
//   bool? isUploaded;

//   @HiveField(10, defaultValue: false)
//   bool? isServerDiagnosed;

//   @HiveField(11)
//   List<double> confidenceScore;

//   Diagnosis({
//     required this.mobileId,
//     this.serverId,
//     required this.fileName,
//     required this.filePath,
//     required this.uploadTime,
//     required this.mobileDiagnosis,
//     this.serverDiagnosis,
//     this.manualDiagnosis,
//     this.isBookmarked,
//     this.isUploaded,
//     this.isServerDiagnosed,
//     required this.confidenceScore,
//   });

//   @override
//   String toString() {
//     return "[mobileId: $mobileId, serverId: $serverId, fileName: $fileName, filePath: $filePath, uploadTime: $uploadTime, mobileDiagnosis: $mobileDiagnosis, serverDiagnosis: $serverDiagnosis, manualDiagnosis: $manualDiagnosis, isBookmarked: $isBookmarked, isUploaded: $isUploaded, isServerDiagnosed: $isServerDiagnosed, confidenceScore: $confidenceScore]";
//   }
// }
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
  late String mobileDiagnosis;

  @HiveField(6)
  late String? serverDiagnosis;

  @HiveField(7)
  late String? manualDiagnosis;

  @HiveField(8)
  late bool? isBookmarked;

  @HiveField(9)
  late bool? isUploaded;

  @HiveField(10)
  late bool? isServerDiagnosed;

  @HiveField(11)
  late List<double> confidenceScore;

  Diagnosis({
    required this.mobileId,
    this.serverId,
    required this.fileName,
    required this.filePath,
    required this.uploadTime,
    required this.mobileDiagnosis,
    this.serverDiagnosis,
    this.manualDiagnosis,
    this.isBookmarked,
    this.isUploaded,
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
      mobileDiagnosis: json['mobileDiagnosis'] ?? '',
      serverDiagnosis: json['serverDiagnosis'] ?? '',
      manualDiagnosis: json['manualDiagnosis'] ?? '',
      isBookmarked: json['isBookmarked'] ?? false,
      isUploaded: json['isUploaded'] ?? false,
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
    json['mobileDiagnosis'] = mobileDiagnosis;
    json['serverDiagnosis'] = serverDiagnosis;
    json['manualDiagnosis'] = manualDiagnosis;
    json['isBookmarked'] = isBookmarked;
    json['isUploaded'] = isUploaded;
    json['isServerDiagnosed'] = isServerDiagnosed;
    json['confidenceScore'] = confidenceScore;
    return json;
  }

  @override
  String toString() {
    return "[mobileId: $mobileId, serverId: $serverId, fileName: $fileName, filePath: $filePath, uploadTime: $uploadTime, mobileDiagnosis: $mobileDiagnosis, serverDiagnosis: $serverDiagnosis, manualDiagnosis: $manualDiagnosis, isBookmarked,: $isBookmarked, isUploaded,: $isUploaded, isServerDiagnosed: $isServerDiagnosed, confidenceScore: $confidenceScore]";
  }
}
